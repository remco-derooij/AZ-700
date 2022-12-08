param extIP string




resource ResearchVnet 'Microsoft.Network/virtualNetworks@2019-11-01' = {
  name: 'ResearchVnet'
  location: 'southeastasia'
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.40.0.0/16'
      ]
    }
    subnets: [
      {
        name: 'ResearchSystemSubnet'
        properties: {
          addressPrefix: '10.40.0.0/24'
          networkSecurityGroup: {
            id: NSGResearchVnet.id
          }
        }
      }
    ]
  }
}



resource CoreServicesVnet 'Microsoft.Network/virtualNetworks@2019-11-01' = {
  name: 'CoreServicesVnet'
  location: 'eastus'
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.20.0.0/16'
      ]
    }
    subnets: [
      {
        name: 'GatewaySubnet'
        properties: {
          addressPrefix: '10.20.0.0/27'
        }
      }
      {
        name: 'DatabaseSubnet'
        properties: {
          addressPrefix: '10.20.20.0/24'
          networkSecurityGroup: { 
          id: NSGCoreServicesVnet.id}
        }
      }
      {
        name: 'SharedServicesSubnet'
        properties: {
          addressPrefix: '10.20.10.0/24'
          networkSecurityGroup: { 
            id: NSGCoreServicesVnet.id}
        }
      }
      {
        name: 'PublicWebServiceSubnet'
        properties: {
          addressPrefix: '10.20.30.0/24'
          networkSecurityGroup: { 
            id: NSGCoreServicesVnet.id}
        }
      }
    ]
  }
}




resource ManufacteringVnet 'Microsoft.Network/virtualNetworks@2019-11-01' = {
  name: 'ManufacteringVnet'
  location: 'westeurope'
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.30.0.0/16'
        
      ]
    }
    subnets: [
      {
        name: 'ManufacturingSystemSubnet'
        properties: {
          addressPrefix: '10.30.10.0/24'
          networkSecurityGroup: {
            id: NSGManufacturingVnet.id
          }
        }
        
      }
      {
        name: 'SensorSubnet1'
        properties: {
          addressPrefix: '10.30.20.0/24'
          networkSecurityGroup: {
            id: NSGManufacturingVnet.id
          }
        }
      }
      {
        name: 'SensorSubnet2'
        properties: {
          addressPrefix: '10.30.21.0/24'
          networkSecurityGroup: {
            id: NSGManufacturingVnet.id
          }
        }
      }
      {
        name: 'SensorSubnet3'
        properties: {
          addressPrefix: '10.30.22.0/24'
          networkSecurityGroup: {
            id: NSGManufacturingVnet.id
          }
        }
      }
    ]
  }
}


resource NSGCoreServicesVnet 'Microsoft.Network/networkSecurityGroups@2019-11-01' = {
  name: 'NSG-CoreServicesVnet'
  
  location: 'eastus'
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



resource NSGManufacturingVnet 'Microsoft.Network/networkSecurityGroups@2019-11-01' = {
  name: 'NSG-ManufacturingVnet'
  
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

resource NSGResearchVnet 'Microsoft.Network/networkSecurityGroups@2019-11-01' = {
  name: 'NSG-ResearchVnet'
  
  location: 'southeastasia'
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













resource CoreManuPeering 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2022-05-01' = {
  name: 'CoreManuPeering'
  parent: CoreServicesVnet
  properties: {
    allowForwardedTraffic: true
    remoteVirtualNetwork: {
      id: ManufacteringVnet.id
    }
  }
}



resource ManuCorePeering 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2022-05-01' = {
  name: 'ManuCorePeering'
  dependsOn: [CoreManuPeering ] 
  parent: ManufacteringVnet
  properties: {
    allowForwardedTraffic: true
    remoteVirtualNetwork: {
      id: CoreServicesVnet.id
    }
  }
}







output ResearchVnetid string = ResearchVnet.id

output CoreServicesVnetid string = CoreServicesVnet.id

output ManufacteringVnetid string = ManufacteringVnet.id
