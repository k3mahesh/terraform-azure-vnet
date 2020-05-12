# Virtual Network Module
This Terraform Module Deploys a Virtal Network in Azure with subnet or a set of subnets passed in as input parameters.

The Module does not create nor expose a network security group. This would need to be defined separately, but you can attach those network security group with particular subnet.

|Variable|Default Value|Description|Type|
|---|---|---|---|
|vnet_name|nil|The name of the virtual network. Changing this forces a new resource to be created.|String|
|location|westeurope|The location/region where the virtual network is created. Changing this forces a new resource to be created.|String|
|resource_group_name|nil|The name of the resource group in which to create the virtual network|String|
|vnet_cidr|["10.0.0.0/16"]|The address space that is used the virtual network. You can supply more than one address space. Changing this forces a new resource to be created.|list|
|dns_servers|nil|DNS Servers IP Addresses|list|
|subnet_names|["default"]|List of Subnet Names|list|
|subnet_prefixes|["10.0.0.0/24"]|List of Subnet IP Addresses CIDR|list|
|nsg_ids|nil|A map of subnet names as key attach to Network Security Group IDs|map|
|tags|nil| mapping of tags to assign to the resource.|map|

**Usage**
```
provider "azurerm" {
    version = "~> 2.7.0"
    features {}
}

locals {
  tags = {
        env = "DEV"
        team = "DEV-01"
  }
}

module "resource_group" {
    source   = "../modules/resource_group"
    rg_name  = "DEV-RG"
    location = "westeurope"
   
    tags = local.tags
}

module "virtual_network" {
    source               = "../modules/virtual_network"
    vnet_name            = "k8S-VNET"
    location             = module.resource_group.rg_location
    resource_group_name  = module.resource_group.rg_name
    vnet_cidr            = ["10.0.0.0/16"]
    subnet_names         = ["jump", "management"]
    subnet_prefixes      = ["10.0.0.0/24", "10.0.1.0/24"]

    tags = local.tags
}
```
**Example Attaching Network Security Group with Subnets**
```
provider "azurerm" {
    version = "~> 2.7.0"
    features {}
}

locals {
  tags = {
        env = "AKS-DEV"
        team = "DEV"
  }
}

module "resource_group" {
    source   = "../modules/resource_group"
    rg_name  = "K8S-RG"
    location = "westeurope"
   
    tags = local.tags
}

module "network_security_group_database" {
    source               = "../modules/network_security_group"
    nsg_name             = "K8S-nsg-web"
    location             = module.resource_group.rg_location
    resource_group_name  = module.resource_group.rg_name

    custom_rules = [
        {
            name                         = "ssh"
            priority                     = "110"
            source_port_range            = "*"
            destination_port_range       = "22"
            source_address_prefixes      = "10.0.0.5"
            destination_address_prefixes = "*"
        }
    ]

    tags = local.tags
}

module "virtual_network" {
    source               = "../modules/virtual_network"
    vnet_name            = "k8S-VNET"
    location             = module.resource_group.rg_location
    resource_group_name  = module.resource_group.rg_name
    vnet_cidr            = ["10.0.0.0/16"]
    subnet_names         = ["jump", "management"]
    subnet_prefixes      = ["10.0.0.0/24", "10.0.1.0/24"]

    nsg_ids = {
        management       = module.network_security_group_database.nsg_id
    }

    tags = local.tags
}
```
