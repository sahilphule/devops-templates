az login
az account show
az account list

# Azure Login with Tenant ID
az login --tenant <tenantId>

# Azure Login with Service Principal
az login --service-principal --username <APP_ID> --password <PASSWORD> --tenant <TENANT_ID>

# Azure Container Registry Commands
az acr login --name <registry-name>

# Azure Kubernetes Service
az aks get-credentials --resource-group <resource-group-name> --name <cluster-name> --overwrite-existing