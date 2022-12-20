// param AdminUsername string
// param AdminPassword string
param IntLBVNETVnetid string
param location string

@secure()
param AdminPassword string

param AdminUser string= 'TestUser'
param vmSize string = 'Standard_DS1_v2'





resource BackendNIC01 'Microsoft.Network/networkInterfaces@2022-05-01' = {
  name: 'backendnic01'
  location: location
  properties: {
   ipConfigurations: [
    {
     name: 'ipconfig1'
     properties: {
      privateIPAllocationMethod: 'Dynamic'
      subnet: {
            id: '${IntLBVNETVnetid}/subnets/Databasesubnet'
       
           }
     } 
    }
   ] 
  }
}



resource BackendVM01 'Microsoft.Compute/virtualMachines@2020-12-01' = {
  name: 'BackendVM01'
  location: location
  properties: {
    hardwareProfile: {
      vmSize: vmSize
    }
    osProfile: {
      computerName: 'BackendVM01'
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
        createOption: 'FromImage'
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: BackendNIC01.id
        }
      ]
    }
  }
}




resource BackendNIC02 'Microsoft.Network/networkInterfaces@2022-05-01' = {
  name: 'backendnic02'
  location: location
  properties: {
   ipConfigurations: [
    {
     name: 'ipconfig1'
     properties: {
      privateIPAllocationMethod: 'Dynamic'
      subnet: {
            id: '${IntLBVNETVnetid}/subnets/Databasesubnet'
       
           }
     } 
    }
   ] 
  }
}



resource BackendVM02 'Microsoft.Compute/virtualMachines@2020-12-01' = {
  name: 'BackendVM02'
  location: location
  properties: {
    hardwareProfile: {
      vmSize: vmSize
    }
    osProfile: {
      computerName: 'BackendVM02'
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
        createOption: 'FromImage'
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: BackendNIC02.id
        }
      ]
    }
  }
  // resource Extension2 'extensions@2022-08-01' = {
  //   name: 'InstallIIS'
  // }
}




resource BackendNIC03 'Microsoft.Network/networkInterfaces@2022-05-01' = {
  name: 'backendnic03'
  location: location
  properties: {
   ipConfigurations: [
    {
     name: 'ipconfig1'
     properties: {
      privateIPAllocationMethod: 'Dynamic'
      subnet: {
            id: '${IntLBVNETVnetid}/subnets/Databasesubnet'
       
           }
     } 
    }
   ] 
  }
}



resource BackendVM03 'Microsoft.Compute/virtualMachines@2020-12-01' = {
  name: 'BackendVM03'
  location: location
  properties: {
    hardwareProfile: {
      vmSize: vmSize
    }
    osProfile: {
      computerName: 'BackendVM03'
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
        createOption: 'FromImage'
      }
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: BackendNIC03.id
        }
      ]
    }
  }
}




