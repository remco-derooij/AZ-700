param ManufacteringVnetid string



resource ManufacturingVnetGateway 'Microsoft.Network/virtualNetworkGateways@2020-11-01' = {
  name: 'ManufacturingVnetGateway'
  location: 'westeurope'
  properties: {
    ipConfigurations: [
      {
        name: 'config1'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          subnet: {
            id: '${ManufacteringVnetid}/subnets/GatewaySubnet'
          }
          publicIPAddress: {
            id: manufacturinggwPiP01.id
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



resource manufacturinggwPiP01 'Microsoft.Network/publicIPAddresses@2022-05-01' = {
  name: 'manufacturingPiP01'
  location: 'westeurope'
  properties: {
    publicIPAllocationMethod: 'Static'

  }

  
  sku: {
    tier: 'Regional'
    name: 'Standard'
  }
}

output ManufacturingVnetGatewayid string = ManufacturingVnetGateway.id
