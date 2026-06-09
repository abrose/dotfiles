#!/usr/bin/env node
// Run: node block-complex-bash.test.mjs
// Pipes payloads through block-complex-bash.mjs and asserts on the decision.
import { spawnSync } from 'node:child_process';
import { fileURLToPath } from 'node:url';
import { dirname, join } from 'node:path';
import assert from 'node:assert/strict';

const here = dirname(fileURLToPath(import.meta.url));
const hook = join(here, 'block-complex-bash.mjs');

const run = (command) => {
  const payload = JSON.stringify({ tool_name: 'Bash', tool_input: { command } });
  const res = spawnSync('node', [hook], { input: payload, encoding: 'utf8' });
  assert.equal(res.status, 0, `hook exited ${res.status}: ${res.stderr}`);
  const denied = res.stdout.includes('"permissionDecision":"deny"');
  return { denied, stdout: res.stdout };
};

const expectAllowed = (label, command) => {
  const { denied } = run(command);
  assert.equal(denied, false, `expected ALLOW but got DENY: ${label}`);
  console.log(`  ok (allowed): ${label}`);
};

const expectDenied = (label, command) => {
  const { denied } = run(command);
  assert.equal(denied, true, `expected DENY but got ALLOW: ${label}`);
  console.log(`  ok (denied):  ${label}`);
};

console.log('block-complex-bash detector');

// --- allowed: simple and moderate commands ---
expectAllowed('single command', 'pnpm run test:unit');
expectAllowed('cd && one cmd', 'cd /tmp && pnpm test');
expectAllowed('three-stage pipe (3 segments)', 'cat foo.txt | grep bar | head -5');
expectAllowed('four separators at the limit', 'a && b | c || d; e');
expectAllowed('semicolons inside a quoted string', 'echo "a; b; c; d; e; f; g"');
expectAllowed(
  'pipes inside a heredoc markdown table',
  [
    "glab mr create --description \"$(cat <<'EOF'",
    '## Summary',
    '| col a | col b | col c |',
    '| ----- | ----- | ----- |',
    '| 1 | 2 | 3 |',
    'EOF',
    ')"',
  ].join('\n'),
);

// --- denied: too many real separators ---
expectDenied('five chained statements', 'echo a; echo b; echo c; echo d; echo e; echo f');
expectDenied(
  'the motivating monster command',
  `cd /repo; echo "=== spec files ==="; rtk ls scripts/**/*.spec.ts 2>/dev/null || echo "none"; echo "=== ctx ==="; sed -n '680,750p' commands.ts; echo "=== guide ==="; sed -n '38,46p' guide.ts`,
);

console.log('all assertions passed');
