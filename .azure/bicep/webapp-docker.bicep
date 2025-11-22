@description('Generate a Suffix based on the Resource Group ID')
param suffix string = uniqueString(resourceGroup().id)

@description('Use the Resource Group Location')
param location string = resourceGroup().location

resource acr 'Microsoft.ContainerRegistry/registries@2021-09-01' existing = {
  name: 'cr${suffix}'
}

resource appServicePlan 'Microsoft.Web/serverfarms@2022-03-01' = {
  name: 'asp-${suffix}'
  location: location
  tags: {
    SecurityControl: 'Ignore'
  }
  kind: 'linux'
  properties: {
    reserved: true
  }	
  sku:  {
  	name: 'S1'
  }
}

resource webApp 'Microsoft.Web/sites@2022-03-01' = {
  name: 'app-${suffix}'
  location: location
  tags: {
    SecurityControl: 'Ignore'
  }
  properties: {
    siteConfig: {
      acrUseManagedIdentityCreds: true
      appSettings: []
      linuxFxVersion: 'DOCKER|${acr.properties.loginServer}/eshoponweb/web:latest'
    }
    serverFarmId: appServicePlan.id
  }
  identity: {
    type: 'SystemAssigned'
  }
}
