choco install terraform -y
choco upgrade terraform
terraform -v

terraform init -upgrade
terraform init -reconfigure
terraform init -migrate-state

terraform fmt -recursive
terraform fmt -check

terraform validate

terraform plan
terraform plan -out tfplan.binary

terraform show -json tfplan.binary >tfplan.json

terraform apply
terraform apply -auto-approve
terraform apply -refresh-only
terraform apply -replace <resource-name/module-name>

terraform refresh
terraform force-unlock <lock-id>

terraform state list
terraform state show <name>
terraform state rm <name>
terraform state push <terraform.tfstate>

terraform show

terraform destroy
terraform destroy -auto-approve
terrafrom destroy -target <resource-name/module-name>

terraform console
terraform output

terraform workspace show
terraform workspace list
terraform workspace new <name>
terraform workspace select <name>
terraform workspace delete <name>

ssh-keygen -t rsa -b 4096
ssh-keygen -t dsa 
ssh-keygen -t ecdsa -b 521
ssh-keygen -t ed25519

zip -r <dest-path> <source-path> #for folder
zip <dest-path.zip> <source-path.py> #for specific file
