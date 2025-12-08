## Declare all commands
.PHONY: init plan apply destroy fmt validate

init:
	terraform init -backend-config="$(ARGS)"

fmt:
	@echo "Checking format..."
	terraform fmt -recursive

validate:
	@echo "Validating configuration..."
	terraform validate

plan: fmt validate
	@echo "Planning deployment..."
	terraform plan

apply: fmt validate
	@echo "Applying changes..."
	terraform apply -auto-approve

destroy: validate
	@echo "Destroying infrastructure..."
	terraform destroy -auto-approve