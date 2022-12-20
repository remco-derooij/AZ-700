param IntLBVNETVnetid string


resource BastionHost 'Microsoft.Network/bastionHosts@2022-07-01' = {
  name: 'myBastionHost'
  location: 'westeurope'
  sku: {
     name:  'Standard'
  }
  properties: {
    scaleUnits: 2
    ipConfigurations: [
     {
      name: 'IPConf'
      
      
      properties: {
        publicIPAddress: { 
          id: BastionPiP.id
        }
        subnet: {          
          id: '${IntLBVNETVnetid}/subnets/AzureBastionSubnet'
        }
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
