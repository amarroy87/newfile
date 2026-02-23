targetScope = 'subscription'

@description('Specifies the autonomousDatabases environment')
param env string

@description('Specifies the location')
param location string = 'westeurope'

//
// Load YAML files
//
var inputEnv = {
  DEV: loadYamlContent('../parameters/DEV.yaml')
  SIT: loadYamlContent('../parameters/SIT.yaml')
  CIST: loadYamlContent('../parameters/CIST.yaml')
}

var input = inputEnv[env]

//
// Naming Logic
//
var serviceCode = first(split(input.oracleDelegatedSubnetName, '-'))

var locationShort = {
  westeurope: {
    short: 'weu'
  }
  northeurope: {
    short: 'neu'
  }
}

var envPrefix = '${serviceCode}-${locationShort[location].short}-${toLower(env)}'

var networkingResourceGroupName = '${envPrefix}-connectivity-rg'
var virtualNetworkName = '${envPrefix}-connectivity-vnet'

//
// Existing Networking
//
resource vnet 'Microsoft.Network/virtualNetworks@2022-05-01' existing = {
  name: virtualNetworkName
  scope: resourceGroup(networkingResourceGroupName)
}

resource delegatedSubnet 'Microsoft.Network/virtualNetworks/subnets@2022-11-01' existing = {
  name: input.oracleDelegatedSubnetName
  parent: vnet
}

//
// Oracle Resource Group Creation
//
resource oracleRg 'Microsoft.Resources/resourceGroups@2022-09-01' = {
  name: input.oracleResourceGroupName
  location: location
}

//
// Safe Name (max 14 chars for Oracle)
//
var oracleSafeName = take(
  replace('${serviceCode}${locationShort[location].short}${env}${input.oracleDbName}', '-', ''),
  14
)

//
// Module Deployment
//
module oadbdeploy './test-oadb1.bicep' = {
  name: 'oracleadb-${env}-deployment'
  scope: oracleRg
  params: {
    name: oracleSafeName
    location: location
    subnetId: delegatedSubnet.id
    vnetId: vnet.id
    adminPassword: '' // Ideally retrieve from KeyVault
    computeCount: input.computeCount
    dataStorageSizeInGbs: input.dataStorageSizeInGbs
    licenseModel: input.licenseModel
    dbVersion: input.dbVersion
    dbWorkload: input.dbWorkload
    computeModel: input.computeModel
    isAutoScalingEnabled: input.isAutoScalingEnabled
    isAutoScalingForStorageEnabled: input.isAutoScalingForStorageEnabled
    isMtlsConnectionRequired: input.isMtlsConnectionRequired
    backupRetentionPeriodInDays: input.backupRetentionPeriodInDays
    characterSet: input.characterSet
    ncharacterSet: input.ncharacterSet
    tags: input.tags
  }
}

output autonomousDbId string = oadbdeploy.outputs.autonomousDbId
