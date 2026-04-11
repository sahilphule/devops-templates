# for powershell
[Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes("admin"))
[Text.Encoding]::UTF8.GetString([Convert]::FromBase64String("YWRtaW4="))
powershell -ExecutionPolicy bypass ./apply.ps1

# for linux
echo -n <text> | base64
echo <encoded-text> | base64 --decode
bash apply.sh

# Install kubens
choco install -y kubens kubectx
kubens
kubens <namespace>

# Basis day-to-day commands
kubectl get secrets
kubectl get configmaps
kubectl get pv
kubectl get pvc
kubectl get deployments
kubectl get services
kubectl get all
kubectl get pods
kubectl get volumeattachment
kubectl get roles
kubectl get rolebindings

kubectl apply -f <file-name>
kubectl rollout restart <deployment/deployment-name>
kubectl delete <*>

kubectl describe <pod-name>
kubectl logs <pod-name>

kubectl create configmap <config-name> --from-file=<file-path>
kubectl create namespace <namespace-name>
kubectl create secret docker-registry <secret-name> --docker-server=${AWS_ACCOUNT}.dkr.ecr.${AWS_REGION}.amazonaws.com --docker-username=AWS --docker-password=$(aws ecr get-login-password) --namespace=<namespace-name>
kubectl exec -it <pod-name> -- bash
kubectl cp <src-path> <namespace-name>/${pod}:<dest-path>

# HPA commands
kubectl autoscale deployment <hpa-name> --cpu-percent=50 --min=1 --max=10
kubectl run -i --tty load-generator --rm --image=busybox:1.28 --restart=Never -- /bin/sh -c "while sleep 0.01; do wget -q -O- http://<service-name>:<service-port>; done"
kubectl get hpa <hpa-name> --watch

kubectl get all -A
kubectl get <*>
kubectl get pods -w
kubectl get pods --all-namespaces -o wide --field-selector spec.nodeName=<node-name>
kubectl get secret <secret-name> -o yaml
kubectl get application
kubectl rollout status -w <deployment/deployment-name>
kubectl rollout history <deployment/deployment-name>
kubectl rollout undo <deployment/deployment-name>
kubectl taint nodes --all node.cloudprovider.kubernetes.io/uninitialized-
kubectl port-forward service/<service-name> <desired-port>:<service-port>
$pod = $(kubectl get pod -n <namespace-name> -l <label> -o jsonpath="{.items[0].metadata.name}")

docker context user default
kubectl config view
kubectl config get-contexts
kubectl config current-context
kubectl config use-context <context-name>

kubectl api-versions
kubectl api-resources

kompose convert
