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
      - name: 
        image: :latest
        # Add port
        - containerPort: 
        env:
        - name: 
          value: 'user'
        - name: 
          value: 'password'
        - name: MDATA
          value: 
        volumeMounts:
        - name: data
          mountPath: 

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
  - port: 
    targetPort: 
EOF