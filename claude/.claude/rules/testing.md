# Testing

- Tests MUST cover the functionality being implemented.
- NEVER ignore the output of the system or the tests — logs and messages often contain CRITICAL
  information.
- TEST OUTPUT MUST BE PRISTINE TO PASS. No warnings, no unexpected errors, no noise.
- If the logs are supposed to contain errors, capture and assert on them explicitly.
- You're not allowed to ignore or skip a failing test. If a test fails unexpectedly, it's your
  highest priority to find the root cause and fix it.
- For TDD workflows, delegate to the tdd-coach agent or explicitly request TDD mode.

## Test coverage expectations

By default, every project should have unit tests, integration tests, AND end-to-end tests. If you
believe a test type doesn't apply to the current project, raise it with Chebu rather than silently
skipping it. Chebu can authorize skipping with: "I AUTHORIZE YOU TO SKIP WRITING TESTS THIS TIME"
