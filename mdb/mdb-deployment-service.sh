cat > mdb/mdb-deployment-service.yaml << EOF
# Deployment
apiVersion: apps/v1
kind: Deployment
metadata:
  name: mdb-deployment
  labels: 
    app: mdb
spec:
  # Add replicas
  replicas: 3
  selector: 
    matchLabels:
      app: mdb
  template:
    metadata: 
      labels:
        app: mdb
    spec:
      containers:
      - name: mariadb
        image: mariadb:latest
        ports:
        # Add port
        - containerPort: 3306
        env:
        - name: MYSQL_ROOT_PASSWORD
          value: 'password'
        - name: MYSQL_DATABASE
          value: 'user'
        - name: MYSQL_USER
          value: 'user'
        - name: MYSQL_PASSWORD
          value: 'password'

---
# Service
apiVersion: v1
kind: Service
metadata:
  name: mdb-service
  labels: 
    app: mdb
spec:
  type: ClusterIP
  selector: 
    app: mdb
  ports:
  - port: 3306
    targetPort: 3306

EOF