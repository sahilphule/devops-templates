# Imp:- Use Python 3.8

pip install checkov
terraform plan -out tfplan.binary
terraform show -json tfplan.binary > tfplan.json
checkov -f tfplan.json
