// param AdminUsername string
// param AdminPassword string
param ManufacteringVnetid string
param location string


@secure()
param AdminPassword string

param AdminUser string= 'TestUser'
param vmSize string = 'Standard_DS1_v2'




resource manusysnic01 'Microsoft.Network/networkInterfaces@2022-05-01' = {
  name: 'manusysnic01'
  location: location
  properties: {
   ipConfigurations: [
    {
     name: 'ipconfig1'
     properties: {
      publicIPAddress: {
         id: manusysPiP01.id
      }
      privateIPAllocationMethod: 'Dynamic'
      subnet: {
            id: '${ManufacteringVnetid}/subnets/ManufacturingSystemSubnet'
       
           }
     } 
    }
   ] 
  }
}




resource manusysVM01 'Microsoft.Compute/virtualMachines@2020-12-01' = {
  name: 'manusysVM01'
  location: location
  properties: {
    hardwareProfile: {
      vmSize: vmSize
    }
    osProfile: {
      computerName: 'manusysVM01'
      adminUsername: AdminUser
      adminPassword: AdminPassword
    }
    storageProfile: {
      imageReference: {
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: '2022-Datacenter'
        version: 'latest'
      }
      osDisk: {
        name: 'manusysVM01Disk'
        caching: 'ReadWrite'
        createOption: 'FromImage'
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: manusysnic01.id
        }
      ]
    }
  }
}






resource manusysPiP01 'Microsoft.Network/publicIPAddresses@2022-05-01' = {
  name: 'manusysPiP01'
  location: location

  
  sku: {
    name: 'Basic'
  }
}
