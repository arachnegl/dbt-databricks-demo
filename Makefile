.PHONY: deploy destroy install_dependencies rg_list rg_delete

LOCATION = westeurope
DEPLOYMENT_NAME = demoSubDeployment
RESOURCE_GROUP_NAME = demoResourceGroup
STORAGE_NAME = gregwaef

deploy:
	az deployment sub create \
		--name $(DEPLOYMENT_NAME) \
		--location $(LOCATION) \
		--template-file azure/main.bicep \
		--parameters \
				location=westeurope \
				resourceGroupName=demoResourceGroup \
				storageName=gregwaef

destroy:
	# az deployment sub delete --name $(demoSubDeployment)
  # TODO Why doesn't the above work??
	az group delete --name  $(RESOURCE_GROUP_NAME) --yes

install_dependencies:
	pip install -r requirements.txt

rg_list:
	az group list --query "[].{Name:name, Location:location}" --output table
