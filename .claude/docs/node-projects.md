# Rules for node.js and JS/TypeScript projects

## My preferred tools

- I prefer ```pnpm``` as a package manager

### Testing

- Use Vitest as testing framework
- Test files are co-located with source files (\*.test.ts)
- Integration test files are named (\*.integration.test.ts)
- Coverage reports generated in `coverage/` directory

### Code Quality Tools

- **ESLint**: Configure with TypeScript and Prettier integration
- **Prettier**: Code formatting with custom config in prettier.config.js
- **TypeScript**: Strict type checking with tsconfig.json
- **Vitest**: Modern testing framework with coverage support

## Development Workflow

1. Use `pnpm dev` for rapid development and testing
2. Run `pnpm check-all` before committing to ensure code quality
3. Use `pnpm test:coverage` to verify test coverage

## Code Formatting Guidelines

- Always run `pnpm format` on all edited files to fix the formatting according to the defined rules before using 'git add' or 'git commit'.
