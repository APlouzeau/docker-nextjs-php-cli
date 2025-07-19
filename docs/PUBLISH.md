# Publication Guide

## Steps to publish on npm

### 1. Prerequisites

-   npm account (create at https://www.npmjs.com/)
-   npm CLI installed
-   Project ready for publication

### 2. Preparation

```bash
# Login to npm
npm login

# Verify your identity
npm whoami

# Check package.json is correct
npm pack --dry-run
```

### 3. Version management

```bash
# For patch updates (1.0.0 -> 1.0.1)
npm version patch

# For minor updates (1.0.0 -> 1.1.0)
npm version minor

# For major updates (1.0.0 -> 2.0.0)
npm version major
```

### 4. Publication

```bash
# Publish to npm
npm publish

# For beta versions
npm publish --tag beta
```

### 5. Verification

```bash
# Check the package is available
npm view create-nextjs-php-app

# Test installation
npm install -g create-nextjs-php-app
create-nextjs-php-app test-project
```

## Usage after publication

Users will be able to install and use the CLI with:

```bash
# Global installation
npm install -g create-nextjs-php-app
create-nextjs-php-app my-project

# Direct usage with npx
npx create-nextjs-php-app my-project
```

## Update process

For future updates:

1. Make your changes
2. Update version: `npm version patch/minor/major`
3. Publish: `npm publish`
4. Update GitHub repository: `git push && git push --tags`

## Package visibility

The package will be available at:

-   npm: https://www.npmjs.com/package/create-nextjs-php-app
-   CLI: `npm install -g create-nextjs-php-app`
-   npx: `npx create-nextjs-php-app`
