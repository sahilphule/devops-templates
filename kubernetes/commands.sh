helm create <helm-name>
helm install <custom-name> <helm-name>
helm list -a
helm upgrade <custom-name> <helm-name>
helm rollback <custom-name> <revision-name>
helm install <custom-name> --debug --dry-run <helm-name>
helm template <helm-name>
helm lint <helm-name>
helm uninstall <custom-name>

kubectl apply -f <file-name>
kubectl delete <*>

kubectl get all -A
kubectl get all
kubectl get <*>
kubectl get pods -w
kubectl get pods --all-namespaces -o wide --field-selector spec.nodeName=<node-name>
kubectl get secret <secret-name> -o yaml
kubectl get application
kubectl logs <pod-name>
kubectl describe <pod-name>
kubectl rollout restart <deployment/deployment-name>
kubectl rollout status -w <deployment/deployment-name>
kubectl rollout history <deployment/deployment-name>
kubectl rollout undo <deployment/deployment-name>

kubectl create configmap <config-name> --from-file=<file-path>
kubectl get configmaps
kubectl get secrets

kubens
kubens <namespace>
kubectl create namespace <namespace-name>
kubectl port-forward service/<service-name> <desired-port>:<service-port>

kubectl create secret docker-registry <secret-name> --docker-server=${AWS_ACCOUNT}.dkr.ecr.${AWS_REGION}.amazonaws.com --docker-username=AWS --docker-password=$(aws ecr get-login-password) --namespace=<namespace-name>

kubectl autoscale deployment <hpa-name> --cpu-percent=50 --min=1 --max=10
kubectl run -i --tty load-generator --rm --image=busybox:1.28 --restart=Never -- /bin/sh -c "while sleep 0.01; do wget -q -O- http://<service-name>:<service-port>; done"
kubectl get hpa <hpa-name> --watch

kubectl exec -it <pod-name> -- bash
$pod = $(kubectl get pod -n <namespace-name> -l <label> -o jsonpath="{.items[0].metadata.name}")
kubectl cp <src-path> <namespace-name>/${pod}:<dest-path>

kubectl taint nodes --all node.cloudprovider.kubernetes.io/uninitialized-

docker context user default
kubectl config current-context

minikube start --driver=docker
minikube docker-env | Invoke-Expression
minikube stop

minikube ssh
minikube cp <src-path> <dest-path>
minikube mount <src-path>:<dest-path>
minikube tunnel
minikube service <service-name> -n <namespace-name>
minikube dashboard
minikube addons list
minikube addons enable ingress
minikube addons configure registry-creds
minikube addons enable registry-creds

minikube start — vm-driver=virtualbox
eval $(minikube docker-env)

echo <text> | base64
echo <encoded-text> | base64 --decode

kompose convert