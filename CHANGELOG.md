# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

-   Update checker command (`create-nextjs-php-app check-updates`)
-   Automatic version detection from package.json
-   Changelog file for tracking changes

## [1.0.0] - 2025-01-19

### Added

-   Initial release of create-nextjs-php-app CLI
-   Interactive project creation with Commander.js and Inquirer
-   Three templates: base (complete), starter (auth), clean (minimal)
-   Next.js 15 + TypeScript + Tailwind CSS frontend
-   PHP 8.4 + Apache + MVC architecture backend
-   MariaDB 10.6 database with phpMyAdmin
-   Complete authentication system with JWT
-   Docker Compose configuration with WSL2 optimization
-   Project-specific container naming to avoid conflicts
-   Comprehensive documentation and examples
-   Makefile with development commands
-   npm package publication (11.0 MB optimized)

### Features

-   **Templates**: 3 different project templates
-   **Interactive CLI**: Database name configuration, WSL2 optimization
-   **Authentication**: Complete register/login/logout system
-   **Docker**: Multi-service configuration optimized for development
-   **Documentation**: English documentation with quick-start guides

### Technical Details

-   Package size: 11.0 MB (404 files)
-   Dependencies: Commander.js, Inquirer, Chalk, Ora, fs-extra
-   Templates: Source code only (no node_modules or vendor)
-   Compatibility: Node.js 18+, Docker, Docker Compose

## [Template Versions]

### Backend (PHP 8.4)

-   MVC architecture with Router, Controllers, Models, Entities
-   JWT authentication with Firebase/JWT
-   MariaDB database integration
-   Apache web server with .htaccess
-   Composer dependency management

### Frontend (Next.js 15)

-   TypeScript configuration
-   Tailwind CSS styling
-   App Router architecture
-   Authentication middleware
-   State management with Zustand
-   pnpm package manager

### Database (MariaDB 10.6)

-   User management schema
-   phpMyAdmin interface
-   Docker volume persistence
-   SQL initialization scripts

---

## Version Strategy

### Semantic Versioning

-   **MAJOR**: Breaking changes to CLI interface or templates
-   **MINOR**: New features, templates, or significant improvements
-   **PATCH**: Bug fixes, documentation updates, minor improvements

### Update Policy

-   CLI updates are independent of generated projects
-   Generated projects don't auto-update
-   Breaking changes will be clearly documented
-   Migration guides provided for major updates
