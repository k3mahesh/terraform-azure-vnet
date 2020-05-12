variable "vnet_name" {
    description = "The name of the virtual network. Changing this forces a new resource to be created"
}

variable "location" {
    description = "The location/region where the virtual network is created. Changing this forces a new resource to be created"
    default     = "westeurope"
}

variable "resource_group_name" {
    description = "The name of the resource group in which to create the virtual network"
}

variable "vnet_cidr" {
    description = "The address space that is used the virtual network. You can supply more than one address space. Changing this forces a new resource to be created"
    default     = ["10.0.0.0/16"]
}

variable "enable_ddos" {
    description = "Enable of Disable DDOS Protection for Virtual Network"
    default     = false
}

variable "ddos_protection_name" {
    description = "Name of ddos Protection Plan"
    default     = "K8S-Pro"
}

variable "dns_servers" {
    description = "DNS Servers IP Addresses"
    default     = []
}

variable "subnet_names" {
    description = "List of Subnet Names"
    default     = ["default"]
}

variable "subnet_prefixes" {
    description = "List of Subnet IP Addresses CIDR"
    default     = ["10.0.0.0/24"]
}

variable "nsg_ids" {
  description = "A map of subnet names as key attach to Network Security Group IDs"
  type        = map(string)

  default = {
  }
}

variable "tags" {
    description = " mapping of tags to assign to the resource."
    type        = map(string)
}







