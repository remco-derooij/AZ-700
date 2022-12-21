param extIP string

resource IntLBVNET 'Microsoft.Network/virtualNetworks@2019-11-01' = {
  name: 'IntLB-VNET'
  location: 'westeurope'
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.1.0.0/16'
      ]
    }
    subnets: [
      {
        name: 'myBackendSubnet'
        properties: {
          addressPrefix: '10.1.0.0/24'
        }
      }
      {
        name: 'AzureBastionSubnet'
        properties: {
          addressPrefix: '10.1.1.0/24'
          }
      }
      {
        name: 'myFrontEndSubnet'
        properties: {
          addressPrefix: '10.1.2.0/24'
          }
      }


    ]
  }
}


resource NSGBackend 'Microsoft.Network/networkSecurityGroups@2019-11-01' = {
  name: 'NSG-Backend'
  
  location: 'westeurope'
  properties: {
    securityRules: [
      {
        name: 'rule-allow-RDP'
        properties: {
          description: 'RULE-ALLOW-RDP'
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '3389'
          sourceAddressPrefix: extIP
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 150
          direction: 'Inbound'
        }
      }
    ]
  }
}




output IntLBVNETid string = IntLBVNET.id
