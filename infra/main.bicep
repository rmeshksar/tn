targetScope = 'subscription'

param environmentName string
param location string

var tags = { 'azd-env-name': environmentName }

resource rg 'Microsoft.Resources/resourceGroups@2022-09-01' = {
  name: 'rg-${environmentName}'
  location: location
  tags: tags
}

module api './api.bicep' = {
  scope: rg
  name: 'api-module'
  params: {
    location: location
    environmentName: environmentName
  }
}
