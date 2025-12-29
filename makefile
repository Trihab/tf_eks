## Declare all commands
.PHONY: init plan apply destroy fmt validate kubeconfig

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

kubeconfig:
	@echo "Creating Kubeconfig..."
	aws eks update-kubeconfig --region $(REGION) --name $(NAME)
	@echo "Listing Nodes..."
	kubectl get nodes