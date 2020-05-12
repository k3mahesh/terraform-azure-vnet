# Resource Group Module
This terraform module deploys a Resource Group in Azure with location and tags passed in as input parameters.

**Variables**
|Variable|Default Value|Description|Type|
|---|---|---|---|
|rg_name|nil|Name of Resource Group|String|
|location|westeurope|Resion, Where you want to deploy this reosurce|String|
|tegs|nil|Tags of Resource Group|Map|

**Usage**
```
provider "azurerm" {
    version = "~> 2.7.0"
    features {}
}

module "resource_group" {
    source   = "../modules/resource_group"
    rg_name  = "K8S-RG"
    location = "westeurope"
   
    tags = {
        name = "T-RG"
        env = "AKS"
        team = "DEV"
    }
}
```
