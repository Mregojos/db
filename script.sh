# kubectl and minikube
sh kubectl-minikube.sh

# Create a sample deployment.yaml
sh manifest/deployment.sh

# Create a sample psql.yaml (Deployment Kind)
sh psql/psql-deployment.sh
# Apply
kubectl apply -f psql/psql-deployment.yaml
# Expose
kubectl expose deployment.apps/psql-deployment
# Port-forwarding
kubectl port-forward psql-deployment : --address 
# Watch
watch kubectl get all

# Create a firewall
sh firewall.sh
# Delete the firewall
sh firewall-cleanup.sh