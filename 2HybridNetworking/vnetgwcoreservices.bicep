param CoreServicesVnetid string



resource CoreServicesVnetGateway 'Microsoft.Network/virtualNetworkGateways@2020-11-01' = {
  name: 'CoreServicesVnetGateway'
  location: 'eastus'
  properties: {
    ipConfigurations: [
      {
        name: 'config1'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: '${CoreServicesVnetid}/subnets/GatewaySubnet'
          }
          publicIPAddress: {
            id: coreservicesgwPiP01.id
          }
        }
      }
    ]
    sku: {
      name: 'VpnGw1'
      tier: 'VpnGw1'
      
    }
    vpnGatewayGeneration:'Generation1'
    gatewayType: 'Vpn'
    vpnType: 'RouteBased'
    enableBgp: false
  }
}





resource coreservicesgwPiP01 'Microsoft.Network/publicIPAddresses@2022-05-01' = {
  name: 'coreservicesgwPiP01'
  location: 'eastus'
  properties: {
    publicIPAllocationMethod: 'Static'

  }

  
  sku: {
    tier: 'Regional'
    name: 'Standard'
  }
}


output CoreServicesVnetGatewayid string = CoreServicesVnetGateway.id
