#---------Database Credentials----------#
export DB_NAME="user"
export DB_USER="user"
export DB_HOST=$(gcloud compute instances list --filter="name=matt" --format="value(networkInterfaces[0].accessConfigs[0].natIP)") 
export DB_PORT=11000
export DB_PASSWORD="password"
export TARGET_PORT=5432
export ADDRESS="0.0.0.0"