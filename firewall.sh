# Create a firewall (GCP)
if gcloud compute firewall-rules list --filter="name=db" --format="table(name)" | grep -q db; then
    echo "Already created"
else
    gcloud compute --project=$(gcloud config get project) firewall-rules create db \
        --direction=INGRESS --priority=1000 --network=default --action=ALLOW --rules=tcp:11000,tcp:5000,tcp:12000,tcp:8000 --source-ranges=0.0.0.0/0 
fi

