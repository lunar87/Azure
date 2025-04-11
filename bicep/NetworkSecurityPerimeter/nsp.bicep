param location string = resourceGroup().location
param adminUsername string
@secure()
param adminPassword string
param prefix string
param secondSubId string
param secondResourceGroup string
param logAnalyticsWorkspaceId string // Add this parameter for Log Analytics workspace ID

var uniqueStr = uniqueString(resourceGroup().id)
var suffix = substring(uniqueStr, 0, 6)

var storageAccountName = '${prefix}stg${suffix}'
var keyVaultName = '${prefix}kv6-${suffix}'
var vmName = '${prefix}vm-${suffix}'
var storageAccountName2 = '${prefix}stg2${suffix}'
var storageAccountName3 = '${prefix}stg3${suffix}'
var storageAccountName4 = '${prefix}stg4${suffix}'
var vnetName = '${prefix}vnet-${suffix}'
var subnetName = 'apps'
var nsgName = '${prefix}nsg-${suffix}'
var nspName = '${prefix}nsp-${suffix}'
var nspProfileName = '${prefix}nspprof-${suffix}'
var nspProfileAssocName = '${prefix}nspprofassoc-${suffix}'
var bastionHostName = '${prefix}bastion-${suffix}'

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

resource diagnosticSetting 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = {
  name: '${nspName}-diagnostic'
  scope: nsp
  properties: {
    workspaceId: logAnalyticsWorkspaceId
    logs: [
    ]
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
          networkSecurityGroup: {
            id: nsg.id
          }
          privateEndpointNetworkPolicies: 'Disabled'
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

resource storageAccountEnforce 'Microsoft.Storage/storageAccounts@2023-01-01' = {
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
    }
  }
}

resource storageAccountLearn 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: storageAccountName2
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    networkAcls: {
      bypass: 'AzureServices'
      defaultAction: 'Deny'
    }
  }
}

resource storageAccountNoPerim 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: storageAccountName3
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    networkAcls: {
      bypass: 'AzureServices'
      defaultAction: 'Deny'
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
    enableSoftDelete: true
    enablePurgeProtection: true
    sku: {
      family: 'A'
      name: 'standard'
    }
    enableRbacAuthorization: true
    accessPolicies: []
    networkAcls: {
      bypass: 'AzureServices'
      defaultAction: 'Deny'
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
          privateLinkServiceId: storageAccountEnforce.id
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

module cmk 'cmk.bicep' = {
  name: '${prefix}-cmk'
  params: {
    keyVaultName: keyVaultName
    location: location
  }
  dependsOn: [
    keyVault
  ]
}

module storageOtherSub 'sub2storage.bicep' = {
  name: 'storageAccountModule'
  scope: resourceGroup(secondSubId, secondResourceGroup)
  params: {
    storageAccountName: storageAccountName4
    location: location
  }
}

output storageAccountIdOtherSub string = storageOtherSub.outputs.storageAccountId
output managedIdentityId string = cmk.outputs.managedIdentityId
output rsaKeyId string = cmk.outputs.rsaKeyId



