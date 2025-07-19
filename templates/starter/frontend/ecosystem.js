module.exports = {
    apps: [
        {
            name: "{{PROJECT_NAME}}-preprod",
            script: "npm",
            args: "run start",
            watch: true,
            env: {
                NODE_ENV: "development",
            },
        },
    ],
};
