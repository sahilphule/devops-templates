minikube addons enable ingress
kubectl get pods -n ingress-nginx
kubectl create deployment web --image=gcr.io/google-samples/hello-app:1.0
kubectl expose deployment web --type=NodePort --port=8080
kubectl get service web
minikube service web --url
curl http://<minikube-ip>:<node-port>
kubectl apply -f service/networking/example-ingress.yaml
kubectl get ingress
curl --resolve "hello-world.info:80:<minikube-ip>" -i http://hello-world.info
