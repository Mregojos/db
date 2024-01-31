cat > mdb/mdb-statefulset.yaml << EOF
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: mdb-statefulset
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
      volumes:
      - name: data
        persistentVolumeClaim:
          claimName: mdb-data
      containers:
      # Image and Port
      - name: mariadb
        image: mariadb:latest
        # Add port
        ports:
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
        - name: MDATA
          value: /var/lib/mysql
        volumeMounts:
        - name: data
          mountPath: /var/lib/mysql

---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: mdb-data
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