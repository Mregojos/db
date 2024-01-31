cat > psql/psql-statefulset.yaml << EOF
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: psql-statefulset
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
      - name: data
        persistentVolumeClaim:
          claimName: psql-data
      containers:
      - name: postgres
        image: postgres:latest
        ports:
        # Add port
        - containerPort: 5432
        env:
        - name: POSTGRES_USER
          value: 'user'
        - name: POSTGRES_PASSWORD
          value: 'password'
        - name: PGDATA
          value: /var/lib/postgresql/data
        volumeMounts:
        - name: data
          mountPath: /var/lib/postgresql/data

---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: psql-data
spec:
  storageClassName: standard
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 1Gi
      
---
apiVersion: v1
kind: Service
metadata:
  name: psql-service
  labels: 
    app: psql
spec:
  type: ClusterIP
  selector: 
    app: psql
  ports:
  - port: 5432
    targetPort: 5432
EOF