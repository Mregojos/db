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
          valueFrom:
            secretKeyRef: 
              name: my-secret
              key: MYSQL_ROOT_PASSWORD
        - name: MYSQL_DATABASE
          valueFrom:
            secretKeyRef: 
              name: my-secret
              key: MYSQL_DATABASE
        - name: MYSQL_USER
          valueFrom:
            secretKeyRef: 
              name: my-secret
              key: MYSQL_USER
        - name: MYSQL_PASSWORD
          valueFrom:
            secretKeyRef: 
              name: my-secret
              key: MYSQL_PASSWORD
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