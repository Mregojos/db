cat > psql/psql-deployment-pv-pvc.yaml << EOF
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
      volumes: 
      - name: psql-pv
        persistentVolumeClaim:
          claimName: psql-pvc
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
        volumeMounts:
          - mountPath: /var/lib/postgresql/data
            name: psql-data

---
apiVersion: v1
kind: PersistentVolume
metadata:
  name: psql-pv
spec:
  capacity:
    storage: 1Gi
  accessModes:
    - ReadWriteOnce
  persistentVolumeReclaimPolicy: Retain
  local:
    path: /data/postgres
    
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: psql-pvc
spec:
  storageClassName: manual
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 1Gi
EOF