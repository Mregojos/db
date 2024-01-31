# kubectl and minikube
sh kubectl-minikube.sh

# Create a sample deployment.yaml
# sh manifest/deployment.sh

# Environment
source env.sh

# Create a firewall
sh firewall.sh

#---------------------- FOR MDB --------------------#

#---------------- Option B: Using Statefulset ----------------------------#
# Stateful Kind
sh mdb/mdb-statefulset.sh

# Apply
kubectl apply -f pmdb/mdb-statefulset.yaml

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
kubectl port-forward service/mdb-service $DB_PORT:$MDB_TARGET_PORT --address $ADDRESS

# Test the DB
# make run_test

# Port-forwarding using pods
# First Pod
kubectl port-forward $(kubectl get pod -o name | head -$FIRST) $DB_PORT:$MDB_TARGET_PORT --address $ADDRESS
# Second Pod
kubectl port-forward $(kubectl get pod -o name | head -$FIRST) $DB_PORT_SECOND:$MDB_TARGET_PORT --address $ADDRESS

# Using kubectl exec
# Execute a command to a conatiner
kubectl exec -it $(kubectl get statefulset -o name) -- <...>
# List database

# List Table

# List Table Poperties

# Connect

# List rows


# Check the data in kubectl
kubectl exec -it $(kubectl get statefulset -o name) -- sh
cd <...>

# Delete statefulset
kubectl delete $(kubectl get statefulset -o name)

# Apply to see if the data persist
kubectl apply -f mdb/mdb-statefulset.yaml
# Using kubectl exec
# Execute a command to a conatiner
kubectl exec -it $(kubectl get statefulset -o name) -- <...>
# Connect

# List rows


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
kubectl exec -it $(kubectl get statefulset -o name) -- <...>

# Delete Persistent Volume
kubectl delete $(kubectl get statefulset -o name)
kubectl delete service/mdb-service
kubectl delete $(kubectl get persistentvolume -o name)
kubectl delete $(kubectl get persistentvolumeclaim -o name) # --force


#----------- Cleanu Up ----------------------#

# Delete the firewall
sh firewall-cleanup.sh