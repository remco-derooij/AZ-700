param ManufacturingVnetid string 
param ResearchVnetid string
param CoreServicesVnetid string


resource dnsZoneContoso 'Microsoft.Network/privatednsZones@2020-06-01' = {
  name: 'contoso.com'
  location: 'global'
}



resource  ManufacturingVnetLink  'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2020-06-01' = {
  parent: dnsZoneContoso
  location:'global'
  name: 'ManufacturingVnetLink'
  properties: {
    registrationEnabled: true
    virtualNetwork: {
      id: ManufacturingVnetid
    }
  }
}

resource  CoreServicesVnetLink  'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2020-06-01' = {
 parent: dnsZoneContoso
 location:'global'
 name: 'CoreServicesVnetLink'
 properties: {
   registrationEnabled: true
   virtualNetwork: {
     id: CoreServicesVnetid
   }
 }
}


resource  ResearchVnetLink  'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2020-06-01' = {
  parent: dnsZoneContoso
  location:'global'
  name: 'ResearchVnetLink'
  properties: {
    registrationEnabled: true
    virtualNetwork: {
      id: ResearchVnetid
    }
  }
}



