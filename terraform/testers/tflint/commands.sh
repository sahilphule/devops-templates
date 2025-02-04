choco install tflint
tflint --version

tflint --init
tflint

# Fix common issues automatically
tflint --fix

# Check specific terraform file
tflint --file=main.tf

# Detailed rule violations
tflint --format=compact
tflint --format=json

# Pass terraform plan -out file
tflint --var-file=tfplan.json

# Enable specific rules
tflint --enable-rule=terraform_unused_declarations

# Disable specific rules
tflint --disable-rule=terraform_unused_declarations

# List all available rules
tflint --list-rules

# Run tflint in CI/CD
tflint --format=compact --no-color

# or add Github Actions
- name: Run TFLint
  run: tflint --init && tflint
