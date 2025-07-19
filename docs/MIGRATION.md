# Migration Guide

This guide helps you migrate between major versions of `create-nextjs-php-app`.

## 🚀 Migration Overview

When the CLI releases major versions (2.0.0, 3.0.0, etc.), there may be breaking changes that require project updates. This guide provides step-by-step instructions for each migration.

## 📋 Before You Migrate

### 1. Backup Your Project

```bash
# Create a backup
cp -r my-project my-project-backup

# Or use git
git add . && git commit -m "Backup before CLI migration"
```

### 2. Check Current Versions

```bash
# Check CLI version
create-nextjs-php-app --version

# Check project was created with which CLI version
cat package.json | grep "cli-version" # (if available)
```

### 3. Review Breaking Changes

-   Read [CHANGELOG.md](../CHANGELOG.md)
-   Check [GitHub Releases](https://github.com/APlouzeau/docker-nextjs-php-cli/releases)
-   Review this migration guide

## 🔄 Migration Strategies

### Strategy 1: Fresh Project (Recommended)

Best for projects that haven't diverged much from the template:

```bash
# Create new project with latest CLI
npx create-nextjs-php-app@latest my-project-new

# Copy your custom code
cp -r my-project/backend/custom/* my-project-new/backend/custom/
cp -r my-project/frontend/src/custom/* my-project-new/frontend/src/custom/

# Copy environment files
cp my-project/backend/.env my-project-new/backend/.env
```

### Strategy 2: Manual Migration

Best for heavily customized projects:

```bash
# Update CLI
npm update -g create-nextjs-php-app

# Create temporary reference project
create-nextjs-php-app reference-project

# Compare and merge changes manually
diff -r my-project/ reference-project/
```

### Strategy 3: Selective Updates

Update only specific parts:

```bash
# Update specific files from new template
cp reference-project/compose.yml my-project/
cp reference-project/makefile my-project/
cp reference-project/frontend/package.json my-project/frontend/
```

---

## 📚 Version-Specific Migrations

### Future: 1.x to 2.0 Migration

_This section will be updated when version 2.0 is released_

**Breaking Changes** (hypothetical):

-   New CLI argument structure
-   Updated Docker Compose format
-   Different template directory structure

**Migration Steps**:

1. Update CLI: `npm update -g create-nextjs-php-app`
2. Create reference project
3. Update compose.yml format
4. Update template structure
5. Test and verify

### Future: 2.x to 3.0 Migration

_This section will be updated when version 3.0 is released_

---

## 🛠️ Component-Specific Migrations

### Docker Configuration

When Docker Compose format changes:

```bash
# Backup current config
cp compose.yml compose.yml.backup

# Update to new format
# (specific instructions will be provided in release notes)

# Test new configuration
make dev
```

### Database Schema

When database schema changes:

```bash
# Backup database
make db-backup

# Apply schema migrations
# (SQL migration scripts will be provided)

# Verify data integrity
make db-check
```

### Frontend Dependencies

When Next.js or other frontend dependencies have breaking changes:

```bash
# Update package.json
cp reference-project/frontend/package.json frontend/

# Update configuration files
cp reference-project/frontend/next.config.ts frontend/
cp reference-project/frontend/tailwind.config.ts frontend/

# Reinstall dependencies
cd frontend && pnpm install
```

### Backend Dependencies

When PHP or Composer dependencies change:

```bash
# Update composer.json
cp reference-project/backend/composer.json backend/

# Update dependencies
cd backend && composer update

# Test backend functionality
make test-backend
```

---

## 🧪 Testing After Migration

### 1. Basic Functionality

```bash
# Start all services
make dev

# Check all services are running
make status

# Test basic endpoints
curl http://localhost:8000/api/health
curl http://localhost:3000
```

### 2. Authentication Flow

```bash
# Test registration
curl -X POST http://localhost:8000/api/register \
  -H "Content-Type: application/json" \
  -d '{"email":"test@test.com","password":"password123"}'

# Test login
curl -X POST http://localhost:8000/api/login \
  -H "Content-Type: application/json" \
  -d '{"email":"test@test.com","password":"password123"}'
```

### 3. Database Connectivity

```bash
# Check database connection
make shell-backend
php -r "
include 'class/ClassDatabase.php';
\$db = new ClassDatabase();
echo 'Database connection: ' . (\$db ? 'OK' : 'Failed') . PHP_EOL;
"
```

### 4. Frontend Build

```bash
# Test frontend build
cd frontend
pnpm build
```

---

## 🚨 Troubleshooting Migration Issues

### Port Conflicts

```bash
# Check port usage
netstat -tulpn | grep -E ':(3000|8000|8081|3306)'

# Update ports in compose.yml if needed
nano compose.yml
```

### Dependency Issues

```bash
# Clear all caches
make clean-all

# Rebuild from scratch
make first-install
```

### Database Connection Issues

```bash
# Reset database
make db-reset

# Check database logs
make logs-db
```

### Permission Issues

```bash
# Fix permissions
sudo chown -R $USER:$USER .
chmod +x scripts/*
```

---

## 📞 Getting Help

If you encounter issues during migration:

1. **Check existing issues**: [GitHub Issues](https://github.com/APlouzeau/docker-nextjs-php-cli/issues)
2. **Create new issue**: Include migration steps you tried and error messages
3. **Join discussions**: [GitHub Discussions](https://github.com/APlouzeau/docker-nextjs-php-cli/discussions)

### Issue Template for Migration Problems

When reporting migration issues, please include:

```
**Migration Path**: 1.x.x -> 2.x.x
**Strategy Used**: Fresh Project / Manual / Selective
**Error Message**: (paste full error)
**Steps Taken**:
1. Updated CLI
2. Created reference project
3. ...

**Environment**:
- OS:
- Node.js version:
- Docker version:
- CLI version:
```

---

## 📝 Migration Checklist

Use this checklist for each migration:

-   [ ] Backup current project
-   [ ] Read changelog and migration notes
-   [ ] Update CLI to latest version
-   [ ] Choose migration strategy
-   [ ] Create reference project (if needed)
-   [ ] Update configuration files
-   [ ] Update dependencies
-   [ ] Test basic functionality
-   [ ] Test authentication flow
-   [ ] Test database connectivity
-   [ ] Test frontend build
-   [ ] Update documentation
-   [ ] Commit changes

---

_This guide will be updated with each major release. Check back for version-specific migration instructions._
