#!bin/sh

helm create <helm-name>
helm install <custom-name> <helm-name>
helm list -a
helm upgrade <custom-name> <helm-name>
helm rollback <custom-name> <revision-name>
helm install <custom-name> --debug --dry-run <helm-name>
helm template <helm-name>
helm lint <helm-name>
helm uninstall <custom-name>
