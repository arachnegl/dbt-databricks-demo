metadata description = 'Creates a storage account and databricks workspace'

targetScope='subscription'

@description('The azure data centre location.')
@minLength(3)
param location string = 'westeurope'
param resourceGroupName string
param storageName string

resource newRG 'Microsoft.Resources/resourceGroups@2022-09-01' = {
  name: resourceGroupName
  location: location
}

module storageAcct 'storage.bicep' = {
  name: 'storageModule'
  scope: newRG
  params: {
    storageLocation: location
    storageName: storageName
  }
}

module databricksWorkspace 'databricksWorkspace.bicep' = {
  name: 'sglDemoDbricks'
  scope: newRG
  params: {
    workspaceName: 'sglDemoDbricks'
  }
}
