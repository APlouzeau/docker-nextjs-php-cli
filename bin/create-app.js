#!/usr/bin/env node

const fs = require("fs-extra");
const path = require("path");
const { program } = require("commander");
const inquirer = require("inquirer");
const chalk = require("chalk");
const ora = require("ora");

// Version du CLI
const packageJson = require("../package.json");
const CLI_VERSION = packageJson.version;

// Commande pour vérifier les mises à jour
program
    .command("check-updates")
    .description("Check for CLI updates")
    .action(async () => {
        const { exec } = require("child_process");
        const util = require("util");
        const execAsync = util.promisify(exec);

        try {
            console.log(chalk.blue("🔍 Checking for updates..."));
            const { stdout } = await execAsync("npm view create-nextjs-php-app version");
            const latestVersion = stdout.trim();

            console.log(chalk.gray(`Current version: ${CLI_VERSION}`));
            console.log(chalk.gray(`Latest version:  ${latestVersion}`));

            if (CLI_VERSION !== latestVersion) {
                console.log(chalk.yellow("\n📦 Update available!"));
                console.log(chalk.white("Run: npm update -g create-nextjs-php-app"));
            } else {
                console.log(chalk.green("\n✅ You're using the latest version!"));
            }
        } catch (error) {
            console.log(chalk.red("❌ Failed to check for updates"));
            console.log(chalk.gray(`Error: ${error.message}`));
        }
    });

program
    .version(CLI_VERSION)
    .argument("<project-name>", "Name of the project to create")
    .description("Create a complete Next.js + PHP + Docker starter application with authentication")
    .action(async (projectName) => {
        console.log(chalk.blue.bold("\n🚀 Creating your Next.js + PHP + Docker starter application...\n"));

        // Questions interactives
        const answers = await inquirer.prompt([
            {
                type: "input",
                name: "databaseName",
                message: "Database name:",
                default: projectName.toLowerCase().replace(/[^a-z0-9]/g, "_"),
            },
            {
                type: "confirm",
                name: "wsl2Optimized",
                message: "Optimize for WSL2?",
                default: true,
            },
        ]);

        const spinner = ora("Generating project structure...").start();

        try {
            // Copier le template starter
            const templatePath = path.join(__dirname, "../templates/starter");
            const projectPath = path.join(process.cwd(), projectName);

            // Options de copie pour exclure les dossiers problématiques
            const copyOptions = {
                filter: (src) => {
                    const relativePath = path.relative(templatePath, src);
                    const excludePatterns = [
                        "node_modules",
                        ".pnpm-store",
                        ".next",
                        "vendor",
                        ".env:Zone.Identifier",
                        "config.php:Zone.Identifier",
                        "credentials.json:Zone.Identifier",
                        "service-account-key.json:Zone.Identifier",
                        "favicon-removebg-preview.png:Zone.Identifier",
                    ];

                    return !excludePatterns.some((pattern) => relativePath.includes(pattern));
                },
            };

            await fs.copy(templatePath, projectPath, copyOptions);

            // Personnaliser les fichiers
            await customizeProject(projectPath, projectName, answers);

            spinner.succeed(chalk.green("Project created successfully!"));

            // Instructions finales
            console.log(chalk.yellow.bold("\n🎯 Next steps:"));
            console.log(chalk.white(`  cd ${projectName}`));
            console.log(chalk.white("  cp backend/.env.example backend/.env"));
            console.log(chalk.white("  # Edit backend/.env with your database credentials"));
            console.log(chalk.white("  make first-install"));
            console.log(chalk.white(""));
            console.log(chalk.green.bold("🎉 Your starter includes:"));
            console.log(chalk.white("  • Complete user authentication (register/login/logout)"));
            console.log(chalk.white("  • User management & posts example"));
            console.log(chalk.white("  • Protected and public routes"));
            console.log(chalk.white("  • Ready-to-use database schema"));

            if (answers.wsl2Optimized) {
                console.log(chalk.blue("\n💡 WSL2 optimization enabled for best performance!"));
            }
        } catch (error) {
            spinner.fail("Error creating project");
            console.error(chalk.red(error.message));
            process.exit(1);
        }
    });

async function customizeProject(projectPath, projectName, answers) {
    // Personnaliser compose.yml spécifiquement
    const composePath = path.join(projectPath, "compose.yml");
    if (await fs.pathExists(composePath)) {
        let composeContent = await fs.readFile(composePath, "utf8");

        // Remplacements spécifiques pour compose.yml
        composeContent = composeContent.replace(/{{DB_NAME}}/g, answers.databaseName);
        composeContent = composeContent.replace(/{{DB_USER}}/g, answers.databaseName);
        composeContent = composeContent.replace(/{{PROJECT_NAME}}_backend/g, `${projectName}_backend`);
        composeContent = composeContent.replace(/{{PROJECT_NAME}}_frontend/g, `${projectName}_frontend`);
        composeContent = composeContent.replace(/{{PROJECT_NAME}}_database/g, `${projectName}_database`);
        composeContent = composeContent.replace(/{{PROJECT_NAME}}_phpmyadmin/g, `${projectName}_phpmyadmin`);

        await fs.writeFile(composePath, composeContent);
    } // Traiter makefile
    const makefilePath = path.join(projectPath, "makefile");
    if (await fs.pathExists(makefilePath)) {
        let content = await fs.readFile(makefilePath, "utf8");
        content = content.replace(/{{DB_NAME}}/g, answers.databaseName);
        content = content.replace(/{{DB_USER}}/g, answers.databaseName);
        await fs.writeFile(makefilePath, content);
    }

    // Traiter frontend/package.json
    const packagePath = path.join(projectPath, "frontend/package.json");
    if (await fs.pathExists(packagePath)) {
        let content = await fs.readFile(packagePath, "utf8");
        content = content.replace(/{{PROJECT_NAME}}/g, projectName);
        await fs.writeFile(packagePath, content);
    }

    // Traiter frontend/ecosystem.js
    const ecosystemPath = path.join(projectPath, "frontend/ecosystem.js");
    if (await fs.pathExists(ecosystemPath)) {
        let content = await fs.readFile(ecosystemPath, "utf8");
        content = content.replace(/{{PROJECT_NAME}}/g, projectName);
        await fs.writeFile(ecosystemPath, content);
    }

    // Traiter backend/.env.example
    const envExamplePath = path.join(projectPath, "backend/.env.example");
    if (await fs.pathExists(envExamplePath)) {
        let content = await fs.readFile(envExamplePath, "utf8");
        content = content.replace(/{{DB_NAME}}/g, answers.databaseName);
        content = content.replace(/{{DB_USER}}/g, answers.databaseName);
        await fs.writeFile(envExamplePath, content);
    }

    // Traiter frontend/src/app/users/page.js
    const usersPagePath = path.join(projectPath, "frontend/src/app/users/page.js");
    if (await fs.pathExists(usersPagePath)) {
        let content = await fs.readFile(usersPagePath, "utf8");
        content = content.replace(/{{PROJECT_NAME}}/g, projectName);
        await fs.writeFile(usersPagePath, content);
    }

    // Traiter db/starter.sql
    const sqlPath = path.join(projectPath, "db/starter.sql");
    if (await fs.pathExists(sqlPath)) {
        let content = await fs.readFile(sqlPath, "utf8");
        content = content.replace(/{{DB_NAME}}/g, answers.databaseName);
        await fs.writeFile(sqlPath, content);
    }

    // Créer .env pour backend si il n'existe pas
    const envPath = path.join(projectPath, "backend/.env");

    if ((await fs.pathExists(envExamplePath)) && !(await fs.pathExists(envPath))) {
        await fs.copy(envExamplePath, envPath);
    }
}

program.parse();
