cat > psql/psql-statefulset.yaml << EOF
# Persistent Volume (PV)
apiVersion: v1
kind: PersistentVolume
metadata:
  name: psql-pv
  labels: 
    type: local
spec:
  capacity:
    storage: 1Gi
  accessModes:
    - ReadWriteOnce
  hostPath:
    path: /home/jupyter/db/data

---
# Persistent Volume Claim (PVC)
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: psql-pvc
  labels: 
    app: psql
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 1Gi

---
# Deployment
apiVersion: apps/v1
kind: Deployment
metadata:
  name: psql-deployment
  labels: 
    app: psql
spec:
  # Add replicas
  replicas: 3
  selector: 
    matchLabels:
      app: psql
  template:
    metadata: 
      labels:
        app: psql
    spec:
      containers:
      - name: postgres
        image: postgres:latest
        ports:
        # Add port
        - containerPort: 5432
        env:
        - name: POSTGRES_USER
          value: 'User'
        - name: POSTGRES_PASSWORD
          value: 'password'
        - name: PGDATA
          value: /var/lib/postgresql/data
    volumes:
    - name: psql-data
      persistentVolumeClaim:
        claimName: psql-pvc

# kubectl exec -it <deployment name> -- psql -U User -d postgres
EOF