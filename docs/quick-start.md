# Quick Start Guide 🚀

## Installation in 3 minutes

### 1. CLI Installation

```bash
# Install via npm (recommended)
npm install -g create-nextjs-php-app

# OR use with npx (no installation)
npx create-nextjs-php-app my-project

# OR from source
git clone https://github.com/APlouzeau/docker-nextjs-php-cli.git
cd docker-nextjs-php-cli
npm install -g .
```

### 2. Project Creation

```bash
create-nextjs-php-app my-project
cd my-project
cp backend/.env.example backend/.env
```

### 3. Startup

```bash
make first-install  # ☕ 2-3 minutes
make dev
```

### 4. Access

-   **App**: http://localhost:3000
-   **API**: http://localhost:8000
-   **DB**: http://localhost:8081

## Essential commands

```bash
make dev      # Start
make down     # Stop
make logs     # View logs
make status   # Services status
```

## First login

1. Go to http://localhost:3000
2. Click "Sign up"
3. Create an account
4. You're logged in! 🎉

## Quick structure

```
my-project/
├── backend/     # PHP API (localhost:8000)
├── frontend/    # Next.js App (localhost:3000)
├── db/          # Database schema
└── compose.yml  # Docker configuration
```

## Common issues

**Port already in use?**

```bash
# Modify ports in compose.yml
nano compose.yml
```

**Container won't start?**

```bash
make logs        # View errors
make restart     # Restart
```

**Permission denied?**

```bash
sudo chown -R $USER:$USER .
```

## Next steps

-   📖 Read the [complete README](../README.md)
-   🔧 Check [API examples](examples/)
-   🎨 Customize the [frontend](../templates/starter/frontend/)
-   🗃️ Modify the [DB schema](../templates/starter/db/)
