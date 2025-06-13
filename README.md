To deploy pg sql on cloud
REGION=australia-southeast1        # choose closest region
DB_INST=django-postgres
DB_NAME=django_db
DB_USER=django

gcloud sql instances create $DB_INST \
    --database-version=POSTGRES_15 \
    --cpu=2 --memory=4GiB \
    --region=$REGION

gcloud sql databases create $DB_NAME --instance=$DB_INST
gcloud sql users create $DB_USER --instance=$DB_INST --password=STRONG_PWD


To run locally :

INSTANCE="$PROJECT_ID:$REGION:$DB_INST"

gcloud run deploy django-api \
  --image $REPO/app:v1 \
  --region $REGION \
  --service-account django-run-sa \
  --add-cloudsql-instances $INSTANCE \
  --set-env-vars INSTANCE_CONNECTION_NAME=$INSTANCE,DATABASE_NAME=$DB_NAME,DATABASE_USER=$DB_USER \
  --set-secrets DATABASE_PASSWORD=projects/$PROJECT_ID/secrets/DB_PWD:latest \
  --allow-unauthenticated
