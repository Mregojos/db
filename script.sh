# kubectl and minikube
sh kubectl-minikube.sh

# Create a sample deployment.yaml
# sh manifest/deployment.sh

# Environment
source env.sh

# Create a firewall
sh firewall.sh

#---------------- Option A: Using Deployment ----------------------#
# It's working.
# Create a sample psql.yaml (Deployment Kind)
sh psql/psql-deployment.sh
sh psql/psql-service.sh
# or
sh psql/psql-deployment-service.sh

# Apply
kubectl apply -f psql/psql-deployment.yaml
kubectl apply -f psql/psql-service.yaml
# or
kubectl apply -f psql/psql-deployment-service.yaml

# Expose
# kubectl expose deployment.apps/psql-deployment

# Port-forwarding
kubectl port-forward service/psql-service $DB_PORT:$TARGET_PORT --address $ADDRESS

# Watch
watch kubectl get all

# Test the DB
make run_test

# Delete
kubectl delete deployment/psql-deployment
kubectl delete service/psql-service

#---------------- Option B: Using Statefulset ----------------------------#


#----------- Cleanu Up ----------------------#

# Delete the firewall
sh firewall-cleanup.sh