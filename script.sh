# kubectl and minikube
sh kubectl-minikube.sh

# Create a sample deployment.yaml
sh manifest/deployment.sh

# Create a sample psql.yaml (Deployment Kind)
sh psql/psql-deployment.sh
# Apply
kubectl apply -f psql/psql-deployment.yaml
# Watch
watch kubectl get all
# Expose
kubectl expose deployment.apps/psql-deployment
# Watch
watch kubectl get all
# Port-forwarding
kubectl port-forward service/psql-deployment : --address 

# Create a firewall
sh firewall.sh
# Delete the firewall
sh firewall-cleanup.sh