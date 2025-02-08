param location string = resourceGroup().location
param secondaryLocation string
param adminUsername string
@secure()
param adminPassword string
param prefix string

var uniqueStr = uniqueString(resourceGroup().id)
var suffix = substring(uniqueStr, 0, 6)

var storageAccountName = '${prefix}stg${suffix}'
var keyVaultName = '${prefix}kv-${suffix}'
var vmName = '${prefix}vm-${suffix}'
var secondaryVmName = '${prefix}vm2-${suffix}'
var vnetName = '${prefix}vnet-${suffix}'
var secondaryVnetName = '${prefix}vnet2-${suffix}'
var subnetName = 'apps'
var nsgName = '${prefix}nsg-${suffix}'
var secondaryNsgName = '${prefix}nsg2-${suffix}'
var nspName = '${prefix}nsp-${suffix}'
var nspProfileName = '${prefix}nspprof-${suffix}'
var nspProfileAssocName = '${prefix}nspprofassoc-${suffix}'
var bastionHostName = '${prefix}bastion-${suffix}'
var secondaryBastionHostName = '${prefix}bastion2-${suffix}'

resource nsp 'Microsoft.Network/networkSecurityPerimeters@2023-08-01-preview' = {
  name: nspName
  location: resourceGroup().location
  properties: { }
}

resource nspProf 'Microsoft.Network/networkSecurityPerimeters/profiles@2023-08-01-preview' = {
  location: resourceGroup().location
  name: nspProfileName
  parent: nsp
  properties: {}
}

resource nspassoc 'Microsoft.Network/networkSecurityPerimeters/resourceAssociations@2023-08-01-preview' = {
  location: resourceGroup().location
  name: nspProfileAssocName
  parent: nsp
  properties: {
    accessMode:'Learning'
    privateLinkResource: {
      id: keyVault.id
    }
    profile: {
      id: nspProf.id
    }
  }
}

resource vnet 'Microsoft.Network/virtualNetworks@2023-05-01' = {
  name: vnetName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/21'
      ]
    }
    subnets: [
      {
        name: subnetName
        properties: {
          addressPrefix: '10.0.0.0/24'
          serviceEndpoints: [
            {
              service: 'Microsoft.Storage'
            }
            {
              service: 'Microsoft.KeyVault'
            }
          ]
          networkSecurityGroup: {
            id: nsg.id
          }
        }
      }
    ]
  }
}

resource secondaryVnet 'Microsoft.Network/virtualNetworks@2023-05-01' = {
  name: secondaryVnetName
  location: secondaryLocation
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.1.0.0/21'
      ]
    }
    subnets: [
      {
        name: subnetName
        properties: {
          addressPrefix: '10.1.0.0/24'
          networkSecurityGroup: {
            id: secondaryNsg.id
          }
        }
      }
    ]
  }
}

resource nsg 'Microsoft.Network/networkSecurityGroups@2023-05-01' = {
  name: nsgName
  location: location
  properties: {
    securityRules: [
      
    ]
  }
}

resource secondaryNsg 'Microsoft.Network/networkSecurityGroups@2023-05-01' = {
  name: secondaryNsgName
  location: location
  properties: {
    securityRules: [
      
    ]
  }
}

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    networkAcls: {
      bypass: 'AzureServices'
      defaultAction: 'Deny'
      virtualNetworkRules: [
        {
          id: '${vnet.id}/subnets/${subnetName}'
        }
      ]
    }
  }
}

resource keyVault 'Microsoft.KeyVault/vaults@2023-07-01' = {
  name: keyVaultName
  location: location
  properties: {
    tenantId: subscription().tenantId
    enabledForDeployment: true
    enabledForDiskEncryption: false
    enabledForTemplateDeployment: true
    enableSoftDelete: false
    sku: {
      family: 'A'
      name: 'standard'
    }
    enableRbacAuthorization: true
    accessPolicies: []
    networkAcls: {
      bypass: 'AzureServices'
      defaultAction: 'Deny'
      virtualNetworkRules: [
        {
          id: '${vnet.id}/subnets/${subnetName}'
        }
      ]
    }
  }
}

resource nic 'Microsoft.Network/networkInterfaces@2023-05-01' = {
  name: '${vmName}-nic'
  location: resourceGroup().location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          subnet: {
            id: '${vnet.id}/subnets/${subnetName}'
          }
          privateIPAllocationMethod: 'Dynamic'
        }
      }
    ]
  }
}

resource secondaryNic 'Microsoft.Network/networkInterfaces@2023-05-01' = {
  name: '${secondaryVmName}-nic'
  location: secondaryLocation
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          subnet: {
            id: '${secondaryVnet.id}/subnets/${subnetName}'
          }
          privateIPAllocationMethod: 'Dynamic'
        }
      }
    ]
  }
}

resource virtualMachine 'Microsoft.Compute/virtualMachines@2024-03-01' = {
  name: vmName
  location: resourceGroup().location
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_B2ms'
    }
    osProfile: {
      computerName: vmName
      adminUsername: adminUsername
      adminPassword: adminPassword
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: nic.id
        }
      ]
    }
    storageProfile: {
      imageReference: {
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: '2019-Datacenter'
        version: 'latest'
      }
      osDisk: {
        createOption: 'FromImage'
      }
    }
  }
}

resource secondaryVirtualMachine 'Microsoft.Compute/virtualMachines@2024-03-01' = {
  name: secondaryVmName
  location: secondaryLocation
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_B2ms'
    }
    osProfile: {
      computerName: secondaryVmName
      adminUsername: adminUsername
      adminPassword: adminPassword
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: secondaryNic.id
        }
      ]
    }
    storageProfile: {
      imageReference: {
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: '2019-Datacenter'
        version: 'latest'
      }
      osDisk: {
        createOption: 'FromImage'
      }
    }
  }
}

resource storagePrivateEndpoint 'Microsoft.Network/privateEndpoints@2023-05-01' = {
  name: 'storagePrivateEndpoint'
  location: resourceGroup().location
  properties: {
    subnet: {
      id: '${vnet.id}/subnets/${subnetName}'
    }
    privateLinkServiceConnections: [
      {
        name: 'storageConnection'
        properties: {
          privateLinkServiceId: storageAccount.id
          groupIds: [
            'blob'
          ]
        }
      }
    ]
  }
}

resource keyVaultPrivateEndpoint 'Microsoft.Network/privateEndpoints@2023-05-01' = {
  name: 'keyVaultPrivateEndpoint'
  location: resourceGroup().location
  properties: {
    subnet: {
      id: '${vnet.id}/subnets/${subnetName}'
    }
    privateLinkServiceConnections: [
      {
        name: 'keyVaultConnection'
        properties: {
          privateLinkServiceId: keyVault.id
          groupIds: [
            'vault'
          ]
        }
      }
    ]
  }
}

resource privateDnsZoneBlob 'Microsoft.Network/privateDnsZones@2020-06-01' = {
  name: 'privatelink.${environment().suffixes.storage}'
  location: 'global'
}

resource privateDnsZoneKeyVault 'Microsoft.Network/privateDnsZones@2020-06-01' = {
  name: 'privatelink.vaultcore.azure.net'
  location: 'global'
}

resource privateDnsZoneGroupStorage 'Microsoft.Network/privateEndpoints/privateDnsZoneGroups@2023-05-01' = {
  name: 'storagePrivateDnsZoneGroup'
  parent: storagePrivateEndpoint
  properties: {
    privateDnsZoneConfigs: [
      {
        name: 'storageDnsZoneConfig'
        properties: {
          privateDnsZoneId: privateDnsZoneBlob.id
        }
      }
    ]
  }
}

resource privateDnsZoneGroupKeyVault 'Microsoft.Network/privateEndpoints/privateDnsZoneGroups@2023-05-01' = {
  name: 'keyVaultPrivateDnsZoneGroup'
  parent: keyVaultPrivateEndpoint
  properties: {
    privateDnsZoneConfigs: [
      {
        name: 'keyVaultDnsZoneConfig'
        properties: {
          privateDnsZoneId: privateDnsZoneKeyVault.id
        }
      }
    ]
  }
}

resource vnetLinkBlob 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2020-06-01' = {
  name: '${vnetName}-link'
  parent: privateDnsZoneBlob
  location: 'global'
  properties: {
    virtualNetwork: {
      id: vnet.id
    }
    registrationEnabled: false
  }
}

resource vnetLinkKeyVault 'Microsoft.Network/privateDnsZones/virtualNetworkLinks@2020-06-01' = {
  name: '${vnetName}-link'
  parent: privateDnsZoneKeyVault
  location: 'global'
  properties: {
    virtualNetwork: {
      id: vnet.id
    }
    registrationEnabled: false
  }
}

module bastion 'bastion.bicep' = {
  name: '${prefix}-bastion1'
  dependsOn: [
    vnet
  ]
  params: {
    vnetName: vnetName
    vnetNewOrExisting: 'existing'
    bastionSubnetIpPrefix: '10.0.1.0/26'
    bastionHostName: bastionHostName
    location: location
  }
}

module bastion2 'bastion.bicep' = {
  name: '${prefix}-bastion2'
  dependsOn: [
    secondaryVnet
  ]
  params: {
    vnetName: secondaryVnetName
    vnetNewOrExisting: 'existing'
    bastionSubnetIpPrefix: '10.1.1.0/26'
    bastionHostName: secondaryBastionHostName
    location: location
  }
}



