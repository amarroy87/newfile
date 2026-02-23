targetScope = 'resourceGroup'

@description('OADB Name')
param name string

@description('Location')
param location string

@secure()
@description('Admin Password')
param adminPassword string

@description('Delegated Subnet ID')
param subnetId string

@description('VNet ID')
param vnetId string

@description('CPU Core Count')
param computeCount int

@description('Storage in GB')
param dataStorageSizeInGbs int

@description('License Model')
param licenseModel string

@description('DB Version')
param dbVersion string

@allowed([
  'OLTP'
  'DW'
])
@description('Database Workload')
param dbWorkload string

@description('Compute Model')
param computeModel string

@description('Auto Scaling Enabled')
param isAutoScalingEnabled bool

@description('Auto Scaling For Storage Enabled')
param isAutoScalingForStorageEnabled bool

@description('mTLS Connection Required')
param isMtlsConnectionRequired bool

@description('Backup Retention Period')
param backupRetentionPeriodInDays int

@description('Character Set')
param characterSet string

@description('National Character Set')
param ncharacterSet string

@description('Tags')
param tags object

resource autonomousDb 'Oracle.Database/autonomousDatabases@2025-09-01' = {
  name: name
  location: location
  properties: {
    displayName: name
    dbWorkload: dbWorkload
    dbVersion: dbVersion
    dataBaseType: 'Regular'
    adminPassword: adminPassword
    computeModel: computeModel
    computeCount: computeCount
    dataStorageSizeInGbs: dataStorageSizeInGbs
    isAutoScalingEnabled: isAutoScalingEnabled
    isAutoScalingForStorageEnabled: isAutoScalingForStorageEnabled
    licenseModel: licenseModel
    subnetId: subnetId
    vnetId: vnetId
    isMtlsConnectionRequired: isMtlsConnectionRequired
    backupRetentionPeriodInDays: backupRetentionPeriodInDays
    characterSet: characterSet
    ncharacterSet: ncharacterSet
  }
  tags: tags
}

output autonomousDbId string = autonomousDb.id
