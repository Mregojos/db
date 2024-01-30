cat > psql/psql-deployment-data.yaml << EOF
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
      - name: postgres-data
        hostPath:
          path: /
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
        - name: postgres-data
          mountPath: /var/lib/postgresql/data
EOF