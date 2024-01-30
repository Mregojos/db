# For Dev Firewall Rule
if gcloud compute firewall-rules list --filter="name=db" --format="table(name)" | grep -q db; then
    gcloud compute firewall-rules delete db --quiet
# else
    # echo "$FIREWALL_RULES_NAME-dev Firewall Rule doesn't exist." 
fi