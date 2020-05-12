output "rg_name" {
    description = "Exporting Resource Group Nmae"
    value = azurerm_resource_group.rg.name
}

output "rg_location" {
    description = "Exporting Region of Resource Group"
    value = azurerm_resource_group.rg.location
}

output "rg_id" {
    description = "Resource Group ID"
    value = azurerm_resource_group.rg.id
}