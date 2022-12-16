

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
        name: 'myBastionHost'
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



resource BastionHost 'Microsoft.Network/bastionHosts@2022-07-01' = {
  name: 'myBastionHost'
  location: 'westeurope'
  sku: {
     name:  'Basic'
  }
  properties: {
    scaleUnits: 2
    ipConfigurations: [
     {
      properties: {
        publicIPAddress: { 
          id: BastionPiP.id
        }
        subnet: {id: '${IntLBVNET.id}/subnets/myBastionHost'}
        }
      }]
     }
        
  }




resource BastionPiP 'Microsoft.Network/publicIPAddresses@2022-05-01' = {
  name: 'BastionPiP'
  location: 'westeurope'
  properties: {
    publicIPAllocationMethod: 'Static'

  }

  
  sku: {
    tier: 'Regional'
    name: 'Standard'
  }
}




output IntLBVNETVnetid string = IntLBVNET.id
