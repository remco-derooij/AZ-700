//parameter for password
@secure()
param AdminPassword string

param extIP string

@secure()
param VPNSecret string




module VNET 'vnet.bicep' = {
  name: 'vnet'

  params: {
    extIP: extIP
  }

}

module ComputeCoreServicesDB 'ComputeCoreServicesDB.bicep' = {
  name: 'ComputeCoreServicesDB'
  dependsOn: [VNET]
  params: {
    CoreServicesVnetid:VNET.outputs.CoreServicesVnetid 
    AdminPassword: AdminPassword 
    location: 'eastus'
  }
}


module ComputeManufacturingSystem 'ComputeManufacturingSystem.bicep' = {
  name: 'ComputeManufacturingSystem'
  dependsOn: [VNET]
  params: {
    ManufacteringVnetid:VNET.outputs.ManufacteringVnetid 
    AdminPassword: AdminPassword 
    location: 'westeurope'
  }
}


module vnetgwcoreservices 'vnetgwcoreservices.bicep' = {
  name: 'vnetgwcoreservices'
  dependsOn: [
    VNET
  ]
  params: {
    CoreServicesVnetid:VNET.outputs.CoreServicesVnetid 
  }
}


module vnetgwmanufacturing 'vnetgwmanufacturing.bicep' = {
  name: 'vnetgwmanufacturing'
  dependsOn: [
    VNET
  ]
  params: {
    ManufacteringVnetid:VNET.outputs.ManufacteringVnetid  
  }
}


module vpnconnections 'vpnconnections.bicep' = {
  name: 'vpnconnections'
  dependsOn: [
    vnetgwcoreservices
    vnetgwmanufacturing
  ]
  params: {
     VPNSecret:VPNSecret
     vnetgwmanufacturingid:vnetgwmanufacturing.outputs.ManufacturingVnetGatewayid
     vnetgwcoreservicesid:vnetgwcoreservices.outputs.CoreServicesVnetGatewayid
  }
}
