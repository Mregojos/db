# kubectl and minikube
sh kubectl-minikube.sh

# Create a sample deployment.yaml
# sh manifest/deployment.sh

# Environment
source env.sh

# Create a firewall
sh firewall.sh

#------------------------- FOR PSQL -------------------------------#

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

# Port-forwarding (Another terminal)
kubectl port-forward service/psql-service $DB_PORT:$TARGET_PORT --address $ADDRESS

# Watch
watch kubectl get all

# Test the DB
make run_test

# Using kubectl exec
# Execute a command to a conatiner
kubectl exec -it $(kubectl get deployment -o name) -- psql -U $DB_USER

# Check the data in kubectl
kubectl exec -it $(kubectl get deployment -o name) -- sh
cd var/lib/post*/data

# Delete
kubectl delete deployment/psql-deployment
kubectl delete service/psql-service

#---------------- Option B: Using Statefulset ----------------------------#
# It's working.
# Stateful Kind
sh psql/psql-statefulset.sh

# Apply
kubectl apply -f psql/psql-statefulset.yaml

# Using kubectl get <>
kubectl get all
kubectl get persistentvolume
kubectl get persistentvolumeclaim
kubectl get statefulset

# Get the first pod
# kubectl get pod -o name | head -$FIRST
# Get the second pod
# kubectl get pod -o name | grep ".*-$FIRST"

# Port-forwarding (Another terminal)
kubectl port-forward service/psql-service $DB_PORT:$TARGET_PORT --address $ADDRESS

# Test the DB
make run_test

# Port-forwarding using pods
# First Pod
kubectl port-forward $(kubectl get pod -o name | head -$FIRST) $DB_PORT:$TARGET_PORT --address $ADDRESS
# Second Pod
kubectl port-forward $(kubectl get pod -o name | head -$FIRST) $DB_PORT_SECOND:$TARGET_PORT --address $ADDRESS

# Using kubectl exec
# Execute a command to a conatiner
kubectl exec -it $(kubectl get statefulset -o name) -- psql -U $DB_USER
# List database
\l
# List Table
\d 
# List Table Poperties
\d <TABLE_NAME>
# Connect
\connect <DB or USER>
# List rows
SELECT * FROM <TABLE_NAME>;

# Check the data in kubectl
kubectl exec -it $(kubectl get statefulset -o name) -- sh
cd var/lib/post*/data

# Delete statefulset
kubectl delete $(kubectl get statefulset -o name)

# Apply to see if the data persist
kubectl apply -f psql/psql-statefulset.yaml
# Using kubectl exec
# Execute a command to a conatiner
kubectl exec -it $(kubectl get statefulset -o name) -- psql -U $DB_USER
# Connect
\connect <DB or USER>
# List rows
SELECT * FROM <TABLE_NAME>;

# To see where pvc and pv data store
kubectl describe pvc
kubectl describe pv
# Find Source Path : /tmp/...
# Open Minikube Cluster SSH
minikube ssh
cd /
sudo su
cd /tmp/...

# Backup the data
# pgdump
kubectl exec -it $(kubectl get statefulset -o name) -- pg_dump -U $DB_USER -d user > backup.sql

# Delete Persistent Volume
kubectl delete $(kubectl get statefulset -o name)
kubectl delete service/psql-service
kubectl delete $(kubectl get persistentvolume -o name)
kubectl delete $(kubectl get persistentvolumeclaim -o name) # --force


#----------- Cleanu Up ----------------------#

# Delete the firewall
sh firewall-cleanup.sh