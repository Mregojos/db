cat > psql-deployment.yaml << EOF
apiVersion: apps/v1
kind: Deployment
metadata:
  name: psql-deployment
  labels: 
    app: psql
spec:
  # Add replicas
  replicas: 
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
        - containerPort: 
        env:
        - name: POSTGRES_USER
          value: 'User'
        - name: POSTGRES_PASSWORD
          value: 'password'
EOF