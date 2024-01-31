# kubectl and minikube
sh kubectl-minikube.sh

# Create a sample deployment.yaml
# sh manifest/deployment.sh

# Environment
source env.sh

# Create a firewall
sh firewall.sh

# Test Deployment Kind
# sh mdb/mdb-deployment-service.sh
# Apply
# kubectl apply -f mdb/mdb-deployment-service.yaml
# kubectl get all && kubectl delete $(kubectl get deployment -o name) && kubectl delete service/mdb-service && kubectl get all

#---------------------- FOR MDB --------------------#

#---------------- Option B: Using Statefulset ----------------------------#
# Stateful Kind
sh mdb/mdb-statefulset.sh

# Create a secret 
kubectl create secret generic my-secret --from-literal=MYSQL_ROOT_PASSWORD=password --from-literal=MYSQL_DATABASE=user_db --from-literal=MYSQL_USER=user --from-literal=MYSQL_PASSWORD=password  --type=Opaque 
    
# Apply
kubectl apply -f mdb/mdb-statefulset.yaml

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
make run_test_mdb

# Port-forwarding using pods
# First Pod
kubectl port-forward $(kubectl get pod -o name | head -$FIRST) $DB_PORT:$MDB_TARGET_PORT --address $ADDRESS
# Second Pod
kubectl port-forward $(kubectl get pod -o name | head -$FIRST) $DB_PORT_SECOND:$MDB_TARGET_PORT --address $ADDRESS

# Using kubectl exec
# Execute a command to a conatiner
kubectl exec -it $(kubectl get statefulset -o name) -- mariadb -h localhost -u $DB_USER -p
# password
# List database
SHOW DATABASES;
# Use Database
# USE <DB_NAME>;
USE user;
# List Table
SHOW TABLES;
# CREATE a TABLE
CREATE TABLE INFO (NAME VARCHAR());
# List rows


# Check the data in kubectl
kubectl exec -it $(kubectl get statefulset -o name) -- sh
cd /var/lib/mysql

# Delete statefulset
kubectl delete $(kubectl get statefulset -o name)

# Apply to see if the data persist
kubectl apply -f mdb/mdb-statefulset.yaml
# Using kubectl exec
# Execute a command to a conatiner
kubectl exec -it $(kubectl get statefulset -o name) -- mariadb -h localhost -u $DB_USER -p
# password
# USE <DB_NAME>;
USE user;
# List Table
SHOW TABLES;


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
kubectl exec -it $(kubectl get statefulset -o name) -- sh
# --- mysql
# mysqldump -u user --databases user -p > backup.sql
# kubectl cp <...>

# Delete Persistent Volume
kubectl delete $(kubectl get statefulset -o name)
kubectl delete service/mdb-service
kubectl delete $(kubectl get persistentvolume -o name)
kubectl delete $(kubectl get persistentvolumeclaim -o name) # --force
kubectl delete secret my-secret

#----------- Cleanu Up ----------------------#

# Delete the firewall
sh firewall-cleanup.sh