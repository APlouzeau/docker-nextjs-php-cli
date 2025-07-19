# Docker Next.js + PHP CLI 🚀

A generic CLI to quickly create fullstack applications with Next.js (frontend) and PHP (backend) in a Docker environment.

## ✨ Features

-   **Frontend**: Next.js 15 with TypeScript, Tailwind CSS and pnpm
-   **Backend**: PHP 8.4 with Apache, MVC architecture
-   **Database**: MariaDB 10.6 with phpMyAdmin
-   **Authentication**: Complete system (register/login/logout) with JWT
-   **Docker**: Multi-service configuration with WSL2 optimization
-   **Interactive CLI**: Custom configuration for each project

## 🛠️ Prerequisites

-   Node.js (v18 or higher)
-   Docker and Docker Compose
-   Git

## 📦 Quick Installation

### Method 1: npm install (recommended)

```bash
# Install globally via npm
npm install -g create-nextjs-php-app

# Create a new project
create-nextjs-php-app my-project
```

### Method 2: npx (no installation required)

```bash
# Use directly with npx
npx create-nextjs-php-app my-project
```

### Method 3: From source

```bash
# Clone the repository
git clone https://github.com/APlouzeau/docker-nextjs-php-cli.git
cd docker-nextjs-php-cli

# Install globally
npm install -g .

# Create a new project
create-nextjs-php-app my-project
```

## 🚀 Usage

### 1. Create a new project

```bash
create-nextjs-php-app my-awesome-project
```

The CLI will ask you for:

-   **Database name** (default: project name with underscores)
-   **WSL2 optimization** (recommended on Windows)

### 2. Project configuration

```bash
cd my-awesome-project

# Copy the environment file
cp backend/.env.example backend/.env

# Edit environment variables if necessary
nano backend/.env
```

### 3. Installation and startup

```bash
# Complete installation (dependencies + Docker build)
make first-install

# Start development environment
make dev
```

### 4. Access services

Once started, your application will be accessible at:

-   **Frontend (Next.js)**: http://localhost:3000
-   **Backend (PHP API)**: http://localhost:8000
-   **PhpMyAdmin**: http://localhost:8081
-   **Database**: localhost:3306

## 📁 Generated project structure

```
my-awesome-project/
├── compose.yml              # Docker Compose configuration
├── makefile                 # Development commands
├── backend/                 # PHP API
│   ├── .env.example        # Environment variables
│   ├── composer.json       # PHP dependencies
│   ├── dockerfile          # PHP Docker image
│   ├── public/             # Web entry point
│   │   └── index.php       # Main router
│   ├── class/              # Utility classes
│   ├── config/             # Configuration
│   ├── controller/         # MVC controllers
│   ├── model/              # Data models
│   └── views/              # Templates (optional)
├── frontend/               # Next.js application
│   ├── package.json        # Node.js dependencies
│   ├── dockerfile          # Node.js Docker image
│   ├── src/                # Source code
│   │   ├── app/            # Next.js App Router
│   │   ├── components/     # React components
│   │   └── lib/            # Utilities
│   └── public/             # Static assets
└── db/                     # Database schema
    └── flepourtous.sql     # Initialization script
```

## 🔧 Available Make commands

```bash
# Help
make help

# Complete installation for new project
make first-install

# Development
make dev              # Build + start services
make up               # Start without rebuild
make down             # Stop services
make restart          # Complete restart

# Logs and debug
make logs             # Logs from all services
make logs-backend     # Backend logs only
make logs-frontend    # Frontend logs only
make status           # Services status

# Utilities
make shell-backend    # Shell into backend container
make shell-frontend   # Shell into frontend container
make db-backup        # Database backup

# Cleanup
make clean            # Clean containers and volumes
make clean-all        # Complete cleanup (images, cache)
```

## 🔐 Integrated authentication

The template includes a complete authentication system:

### Backend (PHP)

-   `ControllerAuth`: Handles register/login/logout
-   `ModelUser`: Database operations
-   `EntitieUser`: User data structure
-   JWT for session security

### Frontend (Next.js)

-   Authentication middleware
-   Login/registration pages
-   State management with Zustand
-   Protected and public routes

### Available API endpoints

```
POST /api/register    # Registration
POST /api/login       # Login
POST /api/logout      # Logout
GET  /api/profile     # User profile (protected)
```

## 🛠️ Development

### Environment variables

The `backend/.env` file contains:

```env
# Database
DB_HOST=db
DB_NAME=my_awesome_project
DB_USER=my_awesome_project
DB_PASS=1234

# JWT
JWT_SECRET=your-secret-key

# API
API_BASE_URL=http://localhost:8000
```

### WSL2 optimization

If you're developing on Windows with WSL2, enable optimization when creating the project. This configures:

-   Docker volumes optimized for WSL2
-   Exclusion of `node_modules` from volume mapping
-   Persistent pnpm cache

## 🔄 Updates & Versioning

### CLI Updates

To update the CLI to the latest version:

```bash
# Check for updates
create-nextjs-php-app check-updates

# Update globally installed CLI
npm update -g create-nextjs-php-app

# Or reinstall to get latest version
npm uninstall -g create-nextjs-php-app
npm install -g create-nextjs-php-app@latest

# Check current version
create-nextjs-php-app --version
```

### Version Strategy

We follow [Semantic Versioning](https://semver.org/):

-   **PATCH** (1.0.1): Bug fixes, documentation updates
-   **MINOR** (1.1.0): New features, templates, backwards-compatible changes
-   **MAJOR** (2.0.0): Breaking changes to CLI interface or templates

### Project Updates

Generated projects are **independent** and don't auto-update. To get latest features:

1. **Create a new project** with the updated CLI
2. **Compare and merge** changes manually using tools like:

    ```bash
    # Compare project structures
    diff -r old-project/ new-project/

    # Use git to merge specific files
    git checkout new-project/path/to/file
    ```

3. **Check the changelog** for breaking changes and migration guides

### Update Notifications

The CLI can check for updates:

-   **Manual**: Run `create-nextjs-php-app check-updates`
-   **Automatic**: Checks happen when creating new projects (non-intrusive)

### Breaking Changes

Major version updates may include:

-   Changes to CLI interface or arguments
-   Template structure modifications
-   Dependency requirement updates
-   Docker configuration changes

All breaking changes are documented in [CHANGELOG.md](CHANGELOG.md) with migration guides.

## 🚨 Troubleshooting

### Port conflicts

If ports 3000, 8000, 8081 or 3306 are already in use:

```bash
# Modify ports in compose.yml
nano compose.yml
```

### Containers won't start

```bash
# Check logs
make logs

# Complete restart
make restart

# Clean and restart
make clean && make dev
```

### Permission issues (Linux/WSL)

```bash
# Give permissions to the folder
sudo chown -R $USER:$USER .
```

## 🤝 Contributing

1. Fork the project
2. Create a branch (`git checkout -b feature/my-feature`)
3. Commit (`git commit -am 'Add my feature'`)
4. Push (`git push origin feature/my-feature`)
5. Create a Pull Request

## 📄 License

MIT License - see LICENSE file for more details.

## 🙋‍♂️ Support

For any questions or issues:

-   Open an issue on GitHub
-   Check documentation in `/docs`

---

Created with ❤️ to accelerate Next.js + PHP fullstack development
