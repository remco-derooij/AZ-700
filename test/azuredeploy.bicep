@description('description')
param vmName string

@description('description')
param nicName string

@description('Virtual machine size')
param vmSize string = 'Standard_DS1_v2'

@description('Admin username')
param adminUsername string

@description('Admin password')
@secure()
param adminPassword string

var virtualNetworkName = 'IntLB-VNet'
var nsgName = 'myNSG'
var subnetName = 'myBackendSubnet'
var subnetRef = resourceId('Microsoft.Network/virtualNetworks/subnets', virtualNetworkName, subnetName)
var computeApiVersion = '2018-06-01'
var networkApiVersion = '2018-08-01'

resource vm 'Microsoft.Compute/virtualMachines@[variables(\'computeApiVersion\')]' = {
  name: vmName
  location: resourceGroup().location
  properties: {
    osProfile: {
      computerName: vmName
      adminUsername: adminUsername
      adminPassword: adminPassword
      windowsConfiguration: {
        provisionVmAgent: 'true'
      }
    }
    hardwareProfile: {
      vmSize: vmSize
    }
    storageProfile: {
      imageReference: {
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: '2019-Datacenter'
        version: 'latest'
      }
      osDisk: {
        createOption: 'fromImage'
      }
      dataDisks: []
    }
    networkProfile: {
      networkInterfaces: [
        {
          properties: {
            primary: true
          }
          id: nic.id
        }
      ]
    }
  }
}

resource vmName_VMConfig 'Microsoft.Compute/virtualMachines/extensions@2018-06-01' = {
  name: '${vmName}/VMConfig'
  location: resourceGroup().location
  properties: {
    publisher: 'Microsoft.Compute'
    type: 'CustomScriptExtension'
    typeHandlerVersion: '1.7'
    autoUpgradeMinorVersion: true
    settings: {
      fileUris: [
        'https://raw.githubusercontent.com/tiagocostapt/az-700-labs/master/install-iis.ps1'
      ]
      commandToExecute: 'powershell.exe -ExecutionPolicy Unrestricted -File install-iis.ps1'
    }
  }
  dependsOn: [
    vm
  ]
}

resource nic 'Microsoft.Network/networkInterfaces@[variables(\'networkApiVersion\')]' = {
  name: nicName
  location: resourceGroup().location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          subnet: {
            id: subnetRef
          }
          privateIPAllocationMethod: 'Dynamic'
        }
      }
    ]
    networkSecurityGroup: {
      id: nsg.id
    }
  }
}

resource nsg 'Microsoft.Network/networkSecurityGroups@[variables(\'networkApiVersion\')]' = {
  name: nsgName
  location: resourceGroup().location
  properties: {
    securityRules: [
      {
        name: 'default-allow-rdp'
        properties: {
          priority: 1000
          sourceAddressPrefix: '*'
          protocol: 'Tcp'
          destinationPortRange: '3389'
          access: 'Allow'
          direction: 'Inbound'
          sourcePortRange: '*'
          destinationAddressPrefix: '*'
        }
      }
    ]
  }
}
