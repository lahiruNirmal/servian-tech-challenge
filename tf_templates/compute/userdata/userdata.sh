#! /bin/bash -xe
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

sleep 15
# Download the release v.0.10.0
mkdir app && cd app
# yum install -y wget unzip jq curl

# Get secrets from AWS secret manager
secret=$(aws secretsmanager get-secret-value --secret-id db_secret)
DB_USERNAME=$(echo ${secret} | jq '.SecretString | fromjson | .db_username')
DB_PASSWORD=$(echo ${secret} | jq '.SecretString | fromjson | .db_password')
DB_ENDPOINT=$(echo ${secret} | jq '.SecretString | fromjson | .db_endpoint')
DB_PORT=$(echo ${secret} | jq '.SecretString | fromjson | .db_port')
LISTEN_HOST=$(curl http://169.254.169.254/latest/meta-data/local-ipv4)

echo ${secret}

# Configure conf.toml
wget https://github.com/servian/TechChallengeApp/releases/download/v.0.10.0/TechChallengeApp_v.0.10.0_linux64.zip
unzip TechChallengeApp_v.0.10.0_linux64.zip -d ./
cd dist
ls

sed -i 's/"DbUser" =.*/"DbUser" ="'${DB_USERNAME}'"/g' conf.toml
sed -i 's/"DbPassword" =.*/"DbPassword" ="'${DB_PASSWORD}'"/g' conf.toml
sed -i 's/"DbHost" =.*/"DbHost" ="'${DB_ENDPOINT}'"/g' conf.toml
sed -i 's/"DbPort" =.*/"DbPort" ="'${DB_PORT}'"/g' conf.toml
sed -i 's/"ListenHost" =.*/"ListenHost" ="'${LISTEN_HOST}'"/g' conf.toml

# Get the number of instances in the ASG. If instances are 0, then update db operation needed.
export AWS_DEFAULT_REGION=region
ASG=$(aws autoscaling describe-auto-scaling-groups)
ASG_INSTANCE_COUNT=$(echo ${ASG} | jq -c '.AutoScalingGroups[] | select(.AutoScalingGroupName | contains("test-asg")) | .Instances | length')
ASG_INSTANCE_COUNT=$((ASG_INSTANCE_COUNT))

# Update the database 
if [[ ${ASG_INSTANCE_COUNT} -eq 0 ]]; then
    ./TechChallengeApp updatedb
fi

# Deploy the application
./TechChallengeApp serve
