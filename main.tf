resource "azurerm_virtual_network" "vnet" {
    name                  = var.vnet_name
    location              = var.location
    resource_group_name   = var.resource_group_name
    address_space         = var.vnet_cidr
    dns_servers           = var.dns_servers
    
    tags                  = var.tags
}

resource "azurerm_subnet" "subnet" {
    count                 = length(var.subnet_names)
    name                  = var.subnet_names[count.index]
    resource_group_name   = var.resource_group_name
    virtual_network_name  = azurerm_virtual_network.vnet.name
    address_prefix        = var.subnet_prefixes[count.index]
}

data "azurerm_subnet" "import" {
    for_each                      = var.nsg_ids
    name                          = each.key
    resource_group_name           = var.resource_group_name
    virtual_network_name          = azurerm_virtual_network.vnet.name

    depends_on                    = [azurerm_subnet.subnet]
}

resource "azurerm_subnet_network_security_group_association" "vnet" {
    for_each                      = var.nsg_ids
    subnet_id                     = data.azurerm_subnet.import[each.key].id
    network_security_group_id     = each.value

    depends_on                    = [data.azurerm_subnet.import]
}
