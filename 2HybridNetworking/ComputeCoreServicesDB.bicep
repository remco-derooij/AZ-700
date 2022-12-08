// param AdminUsername string
// param AdminPassword string
param CoreServicesVnetid string
param location string


@secure()
param AdminPassword string

param AdminUser string= 'TestUser'
param vmSize string = 'Standard_DS1_v2'





resource coredbnic01 'Microsoft.Network/networkInterfaces@2022-05-01' = {
  name: 'coredbnic01'
  location: location
  properties: {
   ipConfigurations: [
    {
     name: 'ipconfig1'
     properties: {
      publicIPAddress: {
         id: coredbPiP01.id
      }
      privateIPAllocationMethod: 'Dynamic'
      subnet: {
            id: '${CoreServicesVnetid}/subnets/Databasesubnet'
       
           }
     } 
    }
   ] 
  }
}

resource coredbnic02 'Microsoft.Network/networkInterfaces@2022-05-01' = {
  name: 'coredbnic02'
  location: location
  properties: {
   ipConfigurations: [
    {
     name: 'ipconfig1'
     properties: {
      publicIPAddress: {
         id: coredbPiP02.id
      }
      privateIPAllocationMethod: 'Dynamic'
      subnet: {
            id: '${CoreServicesVnetid}/subnets/Databasesubnet'
       
           }
     } 
    }
   ] 
  }
}


resource coredbVM01 'Microsoft.Compute/virtualMachines@2020-12-01' = {
  name: 'coredbVM01'
  location: location
  properties: {
    hardwareProfile: {
      vmSize: vmSize
    }
    osProfile: {
      computerName: 'coredbVM01'
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
        name: 'coredbVM01Disk'
        caching: 'ReadWrite'
        createOption: 'FromImage'
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: coredbnic01.id
        }
      ]
    }
  }
}





resource coredbVM02 'Microsoft.Compute/virtualMachines@2020-12-01' = {
  name: 'coredbVM02'
  location: location
  properties: {
    hardwareProfile: {
      vmSize: vmSize
    }
    osProfile: {
      computerName: 'coredbVM02'
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
        name: 'VM02disk'
        caching: 'ReadWrite'
        createOption: 'FromImage'
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: coredbnic02.id
        }
      ]
    }
  }
}



resource coredbPiP01 'Microsoft.Network/publicIPAddresses@2022-05-01' = {
  name: 'coredbPiP01'
  location: location
  sku: {
    name: 'Basic'
  }

}



resource coredbPiP02 'Microsoft.Network/publicIPAddresses@2022-05-01' = {
  name: 'coredbPiP02'
  location: location
  sku: {
    name: 'Basic'
  }

}


