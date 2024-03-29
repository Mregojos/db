cat > psql/psql-service.yaml << EOF
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