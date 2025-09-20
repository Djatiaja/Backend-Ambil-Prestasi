# Commit Message Standardization with Husky and Commitlint

This guide explains how to set up commit message standardization using the **Conventional Commits** standard with **Husky** and **Commitlint** in a Node.js project.

## Prerequisites
- Node.js and npm installed
- A Git repository initialized in your project

## Steps

### 1. Install Dependencies
Install Commitlint and Husky as dev dependencies.

```bash
npm install --save-dev @commitlint/cli @commitlint/config-conventional husky
```

### 2. Configure Commitlint
Create a Commitlint configuration file to enforce the Conventional Commits standard.

```bash
echo "module.exports = { extends: ['@commitlint/config-conventional'] };" > commitlint.config.js
```

### 3. Set Up Husky
Initialize Husky to manage Git hooks.

```bash
npx husky install
```

Add a `commit-msg` hook to validate commit messages using Commitlint.

```bash
npx husky add .husky/commit-msg 'npx --no -- commitlint --edit $1'
```

### 4. Update package.json
Add a script to ensure Husky is set up when dependencies are installed.

```json
{
  "scripts": {
    "prepare": "husky install"
  }
}
```

### 5. Test the Setup
Try a commit with a valid Conventional Commits message:

```bash
git commit -m "feat(config): add commitlint with husky"
```

Try an invalid message to verify enforcement:

```bash
git commit -m "Added new feature"
```

This should fail with a Commitlint error.

## Commit Message Format
Follow the **Conventional Commits** standard:

```
<type>(<scope>): <subject>
```

- **type**: `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `build`, `ci`, `chore`, `revert`
- **scope**: Optional, e.g., `auth`, `db`, `api`
- **subject**: Short, imperative, under 50 characters, no period

### Examples
- `feat(api): add user signup endpoint`
- `fix(db): resolve connection timeout issue`
- `docs: update README with setup guide`
- `chore: update dependencies`

## Troubleshooting
- **Husky not running**: Ensure `husky install` ran and `.husky/` exists.
- **Commitlint errors**: Verify `commitlint.config.js` is correctly set up.
- **Permissions issue**: Run `chmod +x .husky/commit-msg` to make the hook executable.
