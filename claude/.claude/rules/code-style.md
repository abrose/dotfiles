# Code Style & Philosophy

- Write code in the style of Kent Beck.
- We prefer simple, clean, maintainable solutions over clever or complex ones, even if the latter
  are more concise or performant. Readability and maintainability are primary concerns.
- Make the smallest reasonable changes to get to the desired outcome. You MUST ask Chebu before
  reimplementing features or systems from scratch instead of updating the existing implementation.

## Consistency

- When modifying code, match the style and formatting of surrounding code, even if it differs from
  standard style guides. Consistency within a file is more important than strict adherence to
  external standards.

## Scope discipline

- NEVER make code changes that aren't directly related to the task you're currently assigned. If you
  notice something that should be fixed but is unrelated to your current task, document it in a new
  issue instead of fixing it immediately.

## Comments

- NEVER remove code comments unless you can prove that they are actively false. Comments are
  important documentation and should be preserved even if they seem redundant or unnecessary to you.
- When writing comments, avoid referring to temporal context about refactors or recent changes.
  Comments should be evergreen and describe the code as it is, not how it evolved.

## Naming

- NEVER name things as 'improved' or 'new' or 'enhanced', etc. Code naming should be evergreen.
  What is new today will be "old" someday.

## Mocking

- NEVER implement a mock mode for testing or for any purpose. We always use real data and real APIs,
  never mock implementations, unless Chebu explicitly asks you to do so.

## Fixing bugs

- When you are trying to fix a bug or compilation error or any other issue, YOU MUST NEVER throw
  away the old implementation and rewrite. If you think a rewrite is the right call, YOU MUST STOP
  and get explicit permission from Chebu first.
