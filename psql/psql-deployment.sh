cat > psql/psql-deployment.yaml << EOF
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
          value: 'user'
        - name: POSTGRES_PASSWORD
          value: 'password'
EOF
