param vnetgwmanufacturingid string
param vnetgwcoreservicesid string


resource CoreServicesGWtoManufacturingGW 'Microsoft.Network/connections@2020-11-01' = {
  name: 'CoreServicesGWtoManufacturingGW'
  location: 'eastus'
  properties: {
    virtualNetworkGateway1: {
      id: vnetgwcoreservicesid
      properties:{}
    }
    virtualNetworkGateway2: {
      id: vnetgwmanufacturingid
      properties:{}
}
    connectionType:  'Vnet2Vnet'
    routingWeight: 0
    sharedKey: 'KnightRider'
  }
}

resource ManufacturingGWtoCoreServicesGW 'Microsoft.Network/connections@2020-11-01' = {
  name: 'ManufacturingGWtoCoreServicesGW'
  location: 'westeurope'
  properties: {
    virtualNetworkGateway1: {
      id: vnetgwmanufacturingid
      properties:{}
    }
    virtualNetworkGateway2: {
      id: vnetgwcoreservicesid
      properties:{}
}
    connectionType:  'Vnet2Vnet'
    routingWeight: 0
    sharedKey: 'KnightRider'
  }
}


