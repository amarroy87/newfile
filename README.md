This is clean AVM-style formatting and will render correctly.

# Oracle Autonomous Database (Shared Exadata) Module

This module deploys an Oracle Autonomous Database (Shared Exadata) into an existing Azure Virtual Network delegated subnet using a subscription-scope orchestration pattern.

---

## Navigation

- [Resource Types](#resource-types)
- [Usage Examples](#usage-examples)
- [Parameters](#parameters)
- [Outputs](#outputs)
- [Cross-Referenced Modules](#cross-referenced-modules)

---

## Resource Types

| Resource Type | API Version |
|--------------|------------|
| Microsoft.Resources/resourceGroups | 2022-09-01 |
| Microsoft.Network/virtualNetworks (existing) | 2022-05-01 |
| Microsoft.Network/virtualNetworks/subnets (existing) | 2022-11-01 |
| Oracle.Database/autonomousDatabases | 2025-09-01 |

---

## Usage Examples

### Subscription Scope Deployment

```bash
az deployment sub create \
  --location westeurope \
  --template-file oadb1.bicep \
  --parameters env=DEV

--------

## Supported Environments

DEV

SIT

CIST

Example YAML Configuration (DEV.yaml)
oracleResourceGroupName: "acd-weu-dev-oadb-rg"
oracleDelegatedSubnetName: "acd-weu-dev-oadb-snet"
oracleDbName: "aodb"
licenseModel: "LicenseIncluded"

computeModel: "ECPU"
computeCount: 8

dbVersion: "19c"
dbWorkload: "DW"

dataStorageSizeInGbs: 1024

isAutoScalingEnabled: true
isAutoScalingForStorageEnabled: true
isMtlsConnectionRequired: true

backupRetentionPeriodInDays: 30
Parameters
oadb1.bicep (Subscription Scope)
Parameter Name	Type	Required	Default	Description
env	string	Yes	-	Environment name (DEV/SIT/CIST)
location	string	No	westeurope	Azure region
test-oadb1.bicep (Module Parameters)
Parameter Name	Type	Required	Description
name	string	Yes	Autonomous DB name
location	string	Yes	Azure region
adminPassword	secure string	Yes	Database admin password
subnetId	string	Yes	Delegated subnet resource ID
vnetId	string	Yes	Virtual Network resource ID
computeCount	int	Yes	Number of ECPU cores
dataStorageSizeInGbs	int	Yes	Storage size in GB
licenseModel	string	Yes	License model
dbVersion	string	Yes	Oracle version (e.g., 19c)
dbWorkload	string	Yes	OLTP or DW
computeModel	string	Yes	Compute model type
isAutoScalingEnabled	bool	Yes	Enable compute auto scaling
isAutoScalingForStorageEnabled	bool	Yes	Enable storage auto scaling
isMtlsConnectionRequired	bool	Yes	Require mTLS connection
backupRetentionPeriodInDays	int	Yes	Backup retention period
characterSet	string	Yes	Database character set
ncharacterSet	string	Yes	National character set
tags	object	Yes	Resource tags
Outputs
Output Name	Type	Description
autonomousDbId	string	Resource ID of deployed Autonomous Database
Cross-Referenced Modules

This module depends on:

Existing connectivity VNet

Delegated subnet for Oracle

Optional integration with:

Private Endpoint module

Diagnostic Settings module

RBAC role assignment module

Key Vault secret module


---

# 🚨 Why Your Version Broke

From your screenshot:

- You pasted without `#` before headings
- No `|` table formatting
- No triple backticks for code
- Everything became one continuous paragraph

Markdown is very strict.  
Even small formatting mistakes break layout.

---

# ✅ After You Paste

1. Click **Preview**
2. It should show:
   - Proper headings
   - Clickable navigation links
   - Clean tables
   - Highlighted bash/yaml blocks

---

If you want, I can now:

- Make it **100% identical to Azure Verified Module format**
- Add AVM-style metadata header
- Add Version + Owners block
- Add module badge section

Tell me and I’ll format it exactly like your cognitive-docai module.
