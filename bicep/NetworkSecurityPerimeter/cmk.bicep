param keyVaultName string
param location string = resourceGroup().location

var managedIdentityName = 'nspManagedIdentity'
var kvKeyName = 'nspKey'

// Remove the storageAccount resource definition
// Remove the keyVault resource definition

resource managedIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2018-11-30' = {
  name: managedIdentityName
  location: location
}

resource keyVault 'Microsoft.KeyVault/vaults@2023-07-01' existing = {
  name: keyVaultName
}

resource keyVaultRoleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(keyVault.id, 'Key Vault Crypto Service Encryption User')
  properties: {
    roleDefinitionId: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', 'e147488a-f6f5-4113-8e2d-b22465e65bf6')
    principalId: managedIdentity.properties.principalId
    principalType: 'ServicePrincipal'  }
}

resource userRoleAssignment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: guid(keyVault.id, 'Key Vault Crypto Officer')
  properties: {
    roleDefinitionId: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '14b46e9e-c2b7-41b4-b07b-48a6ebf60603')
    principalId: deployer().objectId  
  }
}

resource rsaKey 'Microsoft.KeyVault/vaults/keys@2019-09-01' = {
  name: kvKeyName
  parent: keyVault
  properties: {
    kty: 'RSA'
    keySize: 2048
    keyOps: [
      'encrypt'
      'decrypt'
      'sign'
      'verify'
      'wrapKey'
      'unwrapKey'
    ]
  }
}

output keyVaultIdOutput string = keyVault.id
output managedIdentityId string = managedIdentity.id
output rsaKeyId string = rsaKey.id
