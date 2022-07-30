#! /bin/bash

# Configure userdata and db secret name before terraform actions
setup_userdata() {
    #Validate whether user entered all required arguments
    if [[ -z ${AWS_REGION} ]]; then
        echo "Please enter a value for argument --region  "
        echo "Exiting"
        exit 1
    elif [[ -z ${AWS_ACCESS_KEY_ID} ]]; then
        echo "Please enter a value for argument --aws_access_key_id" 
        echo "Exiting"
        exit 1
    elif [[ -z ${AWS_SECRET_ACCESS_KEY} ]]; then
        echo "Please enter a value for argument --aws_secret_access_key" 
        echo "Exiting"
        exit 1
    elif [[ -z ${TF_ACTION} ]]; then
        echo "Please enter a value for argument --tf_action" 
        echo "Exiting"
        exit 1
    fi

    # Validate whether user enters a non tested region
    if [[ ${AWS_REGION} -ne "us-east-1" && ${AWS_REGION} -ne "us-west-2" ]]; then
        echo "Please enter us-east-1 or us-west-2 for region argument"
        echo "Exiting"
        exit 1
    fi

    # Files that need editting before terraform commands run.
    userdata_file_path="./tf_templates/compute/userdata/userdata.sh"
    tfvars_file_path="./tf_templates/terraform.tfvars"

    sed -i 's/region.*/region = "'${AWS_REGION}'"/g' $tfvars_file_path
    
    if [[ -z ${DB_SECRET_NAME} ]]; then 
        sed -i 's/db_secret_name .*/db_secret_name = "tech_challenge_secret"/g' $tfvars_file_path
        export DB_SECRET_NAME="tech_challenge_secret"
        echo "inside"
    else
        sed -i 's/db_secret_name .*/db_secret_name = "'${DB_SECRET_NAME}'"/g' $tfvars_file_path 
        echo "outside"
    fi
    
    terraform fmt -recursive ./tf_templates
    cat ./tf_templates/terraform.tfvars
    sed -i 's/export AWS_DEFAULT_REGION=.*/export AWS_DEFAULT_REGION='${AWS_REGION}'/g' $userdata_file_path
    sed -i 's/secret=$(aws secretsmanager get-secret-value --secret-id.*/secret=$(aws secretsmanager get-secret-value --secret-id '${DB_SECRET_NAME}')/g' $userdata_file_path
    cat $userdata_file_path
    cat $tfvars_file_path

}

# # Terraform validate
tf_validate() {
    setup_userdata
    terraform --version
    terraform init -chdir="${CI_PROJECT_DIR}/tf_templates" ${backend_config}
    terraform validate -chdir="${CI_PROJECT_DIR}/tf_templates"
}

# Terraform plan
tf_plan() {
    setup_userdata
    terraform init ${backend_config} -chdir=${CI_PROJECT_DIR}/tf_templates
    terraform plan -chdir=${CI_PROJECT_DIR}/tf_templates
}

# Terraform apply
tf_apply() {
    setup_userdata
    terraform init ${backend_config} -chdir=${CI_PROJECT_DIR}/tf_templates
    terraform apply -auto-approve -chdir=${CI_PROJECT_DIR}/tf_templates
}

# Terraform destroy
tf_destroy() {
    setup_userdata
    terraform init ${backend_config} -chdir=${CI_PROJECT_DIR}/tf_templates
    terraform destroy -auto-approve -chdir=${CI_PROJECT_DIR}/tf_templates
}



# Get arguments given by user.
while getopts r:d:t:a:s: flag
do
    case "${flag}" in
        r) region=${OPTARG};;
        d) db_secret_name=${OPTARG};;
        t) tf_action=${OPTARG};;
        a) aws_access_key_id=${OPTARG};;
        s) aws_secret_access_key=${OPTARG};;
    esac
done

# Set environment variables
export AWS_REGION=${region}
export AWS_DEFAULT_REGION=$region
export AWS_ACCESS_KEY_ID=$aws_access_key_id
export AWS_SECRET_ACCESS_KEY=$aws_secret_access_key
export TF_ACTION=$tf_action

export TF_ADDRESS="https://gitlab.com/api/v4/projects/${PROJECT_ID}/terraform/state/tech-challenge-state"
export PROJECT_ID="38098168"
export backend_config="-backend-config=address={$TF_ADDRESS} \n
                -backend-config=lock_address=$TF_ADDRESS/lock \n
                -backend-config=unlock_address=$TF_ADDRESS/lock \n
                -backend-config=username=${TF_USERNAME} \n
                -backend-config=password=${TF_PASSWORD} \n
                -backend-config=lock_method=POST \n
                -backend-config=unlock_method=DELETE \n 
                -backend-config=retry_wait_min=5"

if [[ ${TF_ACTION} == "validate" ]]; then
    tf_validate
    echo validate
elif [[ ${TF_ACTION} == "plan" ]]; then
    tf_plan
    echo plan
elif [[ ${TF_ACTION} == "apply" ]]; then
    tf_apply
    echo apply
elif [[ ${TF_ACTION} == "destroy" ]]; then
    tf_destroy
    echo apply
else
    echo "Please enter a value from validate, plan, apply or destroy for tf_action argument"
    echo "Exiting"
    exit 1
fi