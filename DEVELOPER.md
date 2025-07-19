# Developer Guide

This guide is for developers who want to contribute to or maintain the `create-nextjs-php-app` CLI.

## 📋 Table of Contents

-   [Development Setup](#development-setup)
-   [Project Structure](#project-structure)
-   [Release Process](#release-process)
-   [Testing](#testing)
-   [Contributing Guidelines](#contributing-guidelines)
-   [Maintenance](#maintenance)

## 🛠️ Development Setup

### Prerequisites

-   Node.js 18+
-   Git
-   Docker (for testing generated projects)

### Local Development

```bash
# Clone the repository
git clone https://github.com/APlouzeau/docker-nextjs-php-cli.git
cd docker-nextjs-php-cli

# Install dependencies
npm install

# Link CLI globally for testing
npm link

# Test the CLI
create-nextjs-php-app test-project
```

### Development Workflow

```bash
# Check project status
npm run release:check

# Test CLI functionality
npm run release:test

# Check for CLI updates
npm run version:check

# View changelog
npm run changelog
```

## 📁 Project Structure

```
docker-nextjs-php-cli/
├── bin/
│   └── create-app.js          # Main CLI entry point
├── templates/                 # Project templates
│   ├── base/                 # Complete template with e-learning features
│   ├── starter/              # Authentication template
│   └── clean/                # Minimal template
├── docs/                     # Documentation
│   ├── quick-start.md
│   ├── examples.md
│   ├── wsl2-guide.md
│   └── PUBLISH.md
├── scripts/
│   └── release.sh            # Release automation script
├── package.json              # CLI package configuration
├── CHANGELOG.md              # Version history
├── DEVELOPER.md              # This file
└── README.md                 # Main documentation
```

### Key Files

-   **`bin/create-app.js`**: Main CLI logic with Commander.js
-   **`templates/`**: Template directories copied to user projects
-   **`package.json`**: CLI metadata and dependencies
-   **`CHANGELOG.md`**: Semantic versioning history

## 🚀 Release Process

### Semantic Versioning

We follow [Semantic Versioning](https://semver.org/):

-   **PATCH** (1.0.1): Bug fixes, documentation updates
-   **MINOR** (1.1.0): New features, templates, backwards-compatible changes
-   **MAJOR** (2.0.0): Breaking changes to CLI interface or templates

### Automated Release

```bash
# Patch release (bug fixes)
npm run release:patch

# Minor release (new features)
npm run release:minor

# Major release (breaking changes)
npm run release:major
```

### Manual Release Steps

If you need to release manually:

1. **Update version**: `npm version [patch|minor|major]`
2. **Update CHANGELOG.md**: Add release notes
3. **Test CLI**: `npm run release:test`
4. **Commit changes**: `git commit -m "chore: release vX.X.X"`
5. **Tag release**: `git tag vX.X.X`
6. **Publish npm**: `npm publish`
7. **Push to GitHub**: `git push origin main --tags`

## 🧪 Testing

### Manual Testing

```bash
# Test CLI help
create-nextjs-php-app --help

# Test version check
create-nextjs-php-app check-updates

# Test project creation
create-nextjs-php-app test-project
cd test-project
make first-install
```

### Automated Testing

```bash
# Run automated tests
npm run release:test

# This will:
# - Create a test project
# - Verify file structure
# - Check basic functionality
# - Clean up test files
```

### Testing Templates

Each template should be tested for:

-   ✅ File structure completeness
-   ✅ Docker Compose functionality
-   ✅ Database connectivity
-   ✅ Frontend/Backend communication
-   ✅ Authentication flow (where applicable)

## 🤝 Contributing Guidelines

### Adding New Templates

1. **Create template directory**: `templates/new-template/`
2. **Follow existing structure**: Same directory layout as other templates
3. **Update CLI**: Add template option in `bin/create-app.js`
4. **Test thoroughly**: Ensure template works end-to-end
5. **Document**: Add to README.md and examples

### Template Structure

```
templates/template-name/
├── compose.yml               # Docker Compose config
├── makefile                  # Development commands
├── backend/                  # PHP backend
│   ├── .env.example
│   ├── composer.json
│   ├── dockerfile
│   └── ...
├── frontend/                 # Next.js frontend
│   ├── package.json
│   ├── dockerfile
│   └── ...
└── db/                       # Database files
    └── schema.sql
```

### Code Standards

-   **ES6+**: Use modern JavaScript features
-   **Error Handling**: Always handle errors gracefully
-   **User Experience**: Provide clear feedback and progress indicators
-   **Documentation**: Comment complex logic
-   **Consistency**: Follow existing code patterns

### Pull Request Process

1. **Fork** the repository
2. **Create branch**: `git checkout -b feature/new-feature`
3. **Develop** and test your changes
4. **Update** documentation if needed
5. **Submit** pull request with clear description

## 🔧 Maintenance

### Regular Tasks

-   **Monthly**: Check for dependency updates
-   **Quarterly**: Review and update templates
-   **As needed**: Address issues and feature requests

### Dependency Management

```bash
# Check for outdated dependencies
npm outdated

# Update dependencies
npm update

# Audit security
npm audit
```

### Template Maintenance

Templates should be updated when:

-   Next.js releases major versions
-   PHP releases new versions
-   Security vulnerabilities are found
-   New best practices emerge

### Monitoring

Keep track of:

-   **npm downloads**: Track CLI adoption
-   **GitHub issues**: Address user problems
-   **Community feedback**: Improve based on usage

## 📊 Release Checklist

Before each release:

-   [ ] All tests passing
-   [ ] Documentation updated
-   [ ] CHANGELOG.md updated
-   [ ] Version bumped appropriately
-   [ ] Templates tested with latest dependencies
-   [ ] No security vulnerabilities
-   [ ] Breaking changes documented

## 🆘 Troubleshooting

### Common Issues

**Permission Errors**:

```bash
sudo chown -R $USER:$USER .
```

**CLI Not Found**:

```bash
npm unlink
npm link
```

**Template Errors**:

```bash
# Check template validity
npm run release:test
```

### Support Channels

-   **GitHub Issues**: Bug reports and feature requests
-   **Discussions**: Community questions and ideas
-   **Email**: Direct contact for security issues

---

## 🎯 Next Steps

Ready to contribute? Here are some areas that need attention:

1. **New Templates**: API-only, CMS, e-commerce
2. **Database Options**: PostgreSQL, MongoDB support
3. **Frontend Frameworks**: Vue.js, Svelte alternatives
4. **CI/CD**: GitHub Actions integration
5. **Testing**: Automated end-to-end tests

Happy coding! 🚀
