// //parameter for password
// @secure()
// param AdminPassword string

// param extIP string




module VNET 'vnet.bicep' = {
  name: 'vnet'

  // params: {
  //   extIP: extIP
  // }

}

// module ComputeCoreServicesDB 'ComputeCoreServicesDB.bicep' = {
//   name: 'ComputeCoreServicesDB'
//   dependsOn: [VNET]
//   params: {
//     CoreServicesVnetid:VNET.outputs.CoreServicesVnetid 
//     AdminPassword: AdminPassword 
//     location: 'eastus'
//   }
// }


// module ComputeManufacturingSystem 'ComputeManufacturingSystem.bicep' = {
//   name: 'ComputeManufacturingSystem'
//   dependsOn: [VNET]
//   params: {
//     ManufacteringVnetid:VNET.outputs.ManufacteringVnetid 
//     AdminPassword: AdminPassword 
//     location: 'westeurope'
//   }
// }


