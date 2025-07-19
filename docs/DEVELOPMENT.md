# Development Best Practices

This document outlines best practices for developing and maintaining the `create-nextjs-php-app` CLI.

## 🧹 Clean Development Environment

### Before Starting Development

```bash
# Clean up any existing test projects
npm run clean

# Or use the release script directly
./scripts/release.sh clean
```

### Test Project Naming

When testing the CLI, use consistent naming patterns that are automatically ignored:

**✅ Good naming patterns:**

-   `test-my-feature`
-   `demo-authentication`
-   `example-api`
-   `temp-debugging`
-   `cli-test-xxxx`

**❌ Avoid these patterns:**

-   `my-project` (too generic)
-   `project1` (unclear purpose)
-   `app` (too short)

### Git Ignore Strategy

Our `.gitignore` automatically excludes:

```gitignore
# Test projects
test-*
*-test
cli-test-*
my-*-project
demo-*
example-*
temp-*

# Build artifacts
*.tgz
*.log

# Dependencies
node_modules/
vendor/
.next/
```

## 🔧 Development Workflow

### 1. Feature Development

```bash
# 1. Clean environment
npm run clean

# 2. Create feature branch
git checkout -b feature/new-feature

# 3. Develop and test
node bin/create-app.js test-new-feature

# 4. Test CLI commands
npm run release:test

# 5. Clean before commit
npm run clean

# 6. Commit changes
git add .
git commit -m "feat: add new feature"
```

### 2. Testing Workflow

```bash
# Quick CLI test (non-interactive)
npm run release:test

# Manual project creation test
node bin/create-app.js test-manual
cd test-manual
make first-install

# Clean up after testing
npm run clean
```

### 3. Release Workflow

```bash
# Check status
npm run release:check

# Test everything
npm run release:test

# Release patch/minor/major
npm run release:patch
```

## 📁 Project Structure Guidelines

### Template Organization

```
templates/
├── base/          # Full-featured template
├── starter/       # Authentication template
├── clean/         # Minimal template
└── new-template/  # Follow same structure
    ├── compose.yml
    ├── makefile
    ├── backend/
    ├── frontend/
    └── db/
```

### File Naming Conventions

-   **Configuration files**: lowercase with dots (`.env.example`)
-   **Docker files**: lowercase (`dockerfile`, `compose.yml`)
-   **Scripts**: lowercase with hyphens (`create-app.js`)
-   **Documentation**: UPPERCASE (`README.md`, `CHANGELOG.md`)

## 🧪 Testing Guidelines

### Manual Testing Checklist

Before each release, test:

-   [ ] CLI help command: `--help`
-   [ ] Version command: `--version`
-   [ ] Update check: `check-updates`
-   [ ] Project creation with each template
-   [ ] Docker build and startup
-   [ ] Database connectivity
-   [ ] Frontend/backend communication

### Automated Testing

```bash
# Run all automated tests
npm run release:test

# This checks:
# - CLI commands work
# - Required files exist
# - No syntax errors
```

## 🔄 Update Management

### Version Strategy

-   **PATCH** (1.0.1): Bug fixes, typos, minor updates
-   **MINOR** (1.1.0): New templates, features, improvements
-   **MAJOR** (2.0.0): Breaking changes, CLI interface changes

### Changelog Maintenance

Always update `CHANGELOG.md`:

```markdown
## [Unreleased]

### Added

-   New feature description

### Changed

-   Modified behavior description

### Fixed

-   Bug fix description
```

### Breaking Changes

When introducing breaking changes:

1. Document in `CHANGELOG.md`
2. Create migration guide in `docs/migrations/`
3. Update major version
4. Test backward compatibility

## 🚨 Common Issues & Solutions

### Permission Issues

```bash
# Fix script permissions
chmod +x scripts/release.sh

# Fix file ownership
sudo chown -R $USER:$USER .
```

### Git Issues

```bash
# Uncommitted changes before release
git add .
git commit -m "wip: work in progress"

# Or stash changes
git stash
```

### CLI Not Working

```bash
# Reinstall CLI globally
npm unlink
npm link

# Or test directly
node bin/create-app.js test-project
```

### Template Issues

```bash
# Test template validity
node bin/create-app.js test-template-name
cd test-template-name
make first-install
```

## 📝 Documentation Guidelines

### README Updates

When adding features, update:

-   [ ] Feature list
-   [ ] Usage examples
-   [ ] Command descriptions
-   [ ] Troubleshooting section

### Code Comments

```javascript
// ✅ Good: Explains why, not what
// Use inquirer to avoid docker-compose naming conflicts
const projectName = answers.projectName.replace(/[^a-zA-Z0-9]/g, "_");

// ❌ Bad: Explains what (obvious)
// Replace characters in project name
const projectName = answers.projectName.replace(/[^a-zA-Z0-9]/g, "_");
```

## 🔒 Security Guidelines

### Template Security

-   Always use `.env.example` files (never commit secrets)
-   Keep dependencies updated
-   Use official Docker images
-   Validate user inputs

### CLI Security

-   Sanitize file paths
-   Validate template names
-   Check for directory traversal
-   Limit file permissions

## 🎯 Performance Guidelines

### Package Size

Keep the npm package small:

-   Exclude `node_modules` from templates
-   Exclude build artifacts (`.next`, `vendor`)
-   Use `.npmignore` effectively
-   Regular size audits with `npm pack --dry-run`

### Template Performance

-   Optimize Docker images
-   Use multi-stage builds
-   Minimize layer count
-   Cache dependencies effectively

## 📊 Monitoring & Maintenance

### Regular Tasks

-   **Weekly**: Check dependencies for updates
-   **Monthly**: Review GitHub issues and PRs
-   **Quarterly**: Major template updates
-   **As needed**: Security updates

### Metrics to Track

-   npm download statistics
-   GitHub stars and forks
-   Issue resolution time
-   User feedback and feature requests

---

## 🏁 Quick Reference

```bash
# Essential commands
npm run clean              # Clean test projects
npm run release:test       # Test CLI
npm run release:check      # Check status
npm run release:patch      # Release patch
./scripts/release.sh help  # Release script help

# Development cycle
git checkout -b feature/name
# ... develop ...
npm run clean
npm run release:test
git add . && git commit
npm run clean
```

Follow these practices to maintain a clean, efficient, and professional CLI tool! 🚀
