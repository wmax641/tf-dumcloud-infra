ACCOUNT=$(shell aws sts get-caller-identity --query 'Account' --output text)
BASE_NAME=$(shell basename $(CURDIR))
REGION="ap-southeast-2"

init:
	terraform init \
        -backend-config="bucket=tf-${ACCOUNT}"

fmt:
	terraform fmt -write=true --recursive

validate:
	terraform validate

plan:
	terraform plan -input=false -out=tfplan-${ACCOUNT}

apply:
	terraform apply -input=false tfplan-${ACCOUNT}

deploy: plan apply

destroy:
	@printf "🤔 Are you sure you want to destroy? Y/n " ; \
	read -r confirm ; \
	if [ "$$confirm" != "y" ]; then \
		echo "Stopping!" ; \
		exit 67 ; \
	fi
	terraform plan -destroy -input=false -out=tfplan-${ACCOUNT}
	terraform apply -input=false tfplan-${ACCOUNT}
