tf_command=$1
shift
tf_module=$1

if [ ! -z "$tf_module" ]
then
  tf_module="-target=module.${tf_module}"
fi

ENV="${ENV:-whirlwind}"
AWS_REGION="${AWS_REGION:-us-east-1}"
AWS_PROFILE="${AWS_PROFILE:-default}"
#BUCKET="whirlwind-terraform-state-${ENV}"
BUCKET="terraform-bucket-mbriden"

terraform=terraform
tf_key=${ENV}-cicd-pipeline-terraform.tfstate
tf_init_options="-backend-config=profile=${AWS_PROFILE} -backend-config=bucket=${BUCKET} -backend-config=key=${tf_key} -backend-config=region=${AWS_REGION}"
tf_work_options="${tf_module} -var profile=${AWS_PROFILE} -var env=${ENV}"

function generic {
    tfinit
    ${terraform} ${tf_command} ${tf_work_options}
}

function tfinit {
   echo "${terraform} init ${tf_init_options}"
   ${terraform} init ${tf_init_options}
}

function autodestroy {
    tfinit
    ${terraform} destroy ${tf_work_options} -force
}

function autoapply {
    tfinit
    ${terraform} apply -auto-approve ${tf_work_options}
}

case $tf_command in
    init) tfinit;;
    plan) generic;;
    apply) generic;;
    destroy) generic;;
    autodestroy) autodestroy;;
    autoapply) autoapply;;
    *) echo "$tf_command is not a valid command" exit 1;;
esac
