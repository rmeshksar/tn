
param location string
param environmentName string


var resourceToken = toLower(uniqueString(subscription().id, environmentName, location))

resource appPlan 'Microsoft.Web/serverfarms@2022-09-01' = {
  name: 'plan-${resourceToken}'
  location: location
  kind: 'linux'
  properties: {
    reserved: true
  }
  sku: {
    name: 'B1'
  }
}

resource apiApp 'Microsoft.Web/sites@2022-09-01' = {
  name: 'api-${resourceToken}'
  location: location
  tags: { 
    'azd-service-name': 'api'
  }
  properties: {
    httpsOnly: true
    siteConfig: {
      linuxFxVersion: 'DOTNETCORE|6.0'
      alwaysOn: true
    }
    serverFarmId: appPlan.id
  }
}
