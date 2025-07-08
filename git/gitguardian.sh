# Create Git Guardian Account

# Install pre-commit
pip install pre-commit

# Install ggshield
pip install ggshield
pip install --upgrade ggshield
ggshield --version

# Authenticate with GitGuardian
ggshield auth login

# Add this files/folders to .gitignore
.cache_ggshield
.gitguardian.yaml

##################################################################################
# First way

# Initialize ggshield in the local repository
ggshield install --mode local

# Override the existing .pre-commit-config.yaml file
ggshield install --mode local --force

# Initialize the ggshield globally
ggshield install --mode global

##################################################################################
# Second way

# Create .pre-commit-config.yaml in repo's root path
touch .pre-commit-config.yaml

# Add this context inside the file
-----------------

repos:
  - repo: https://github.com/gitguardian/ggshield
    rev: v1.40.0
    hooks:
      - id: ggshield
        language_version: python3
        stages: [pre-commit]

-----------------

# Install pre-commit hooks to Git repo:
pre-commit install

# If getting the following error for the above command, run the below commands.
# [ERROR] Cowardly refusing to install hooks with `core.hooksPath` set
git config --global --unset-all core.hooksPath
git config --unset-all core.hooksPath

###################################################################################

# Scan a specific file or folder
ggshield secret scan path </path/to/code>

# Scan directory
ggshield secret scan path --recursive </path/to/code>

# Scan your entire commited Git repo
ggshield secret scan repo .

# Scan your staged files
ggshield secret scan pre-commit

# Ignore the warning
ggshield secret ignore --last-found

$env:SKIP="ggshield"; git commit -m "your message" # not recommended

# pre-commit scanning through docker image
docker run -e GITGUARDIAN_API_KEY -v $(pwd):/data --rm gitguardian/ggshield ggshield secret scan pre-commit

# Api calls quota (Up to 10,000 API calls per month in free plan)
ggshield quota

# Uninstall ggshield
pip uninstall ggshield

# Uninstall pre-commit
pip uninstall pre-commit

###################################################################################

# Using Husky

# Install Husky
npm install husky --save-dev
npx husky install

# Add this to your package.json
"scripts": {
  "prepare": "husky install"
}

# Run it
npm run prepare

# Add a pre-commit hook
npx husky add .husky/pre-commit

# Install ggshield
pip install ggshield
ggshield auth login

# Edit .husky/pre-commit
# Update the file to:
#!/bin/sh
<. "$(dirname "$0")/_/husky.sh"

echo "🔍 Running GitGuardian scan..."
ggshield secret scan staged || exit 1>
