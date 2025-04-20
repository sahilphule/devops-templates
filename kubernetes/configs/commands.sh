envsubst < ../accessories/nginx-configmap-template.yml > ../accessories/nginx-configmap.yml
envsubst '${ROUTE} ${SERVICE_NAME} ${NAMESPACE} ${SERVICE_PORT} ${SERVER_IP}' < ../accessories/nginx-configmap-template.yml > ../accessories/nginx-conf-configmap.yml
