resource "azurerm_private_endpoint" "cosmos_sql" {
  name                = var.pe_name
  location            = var.location
  resource_group_name = var.rg_name
  subnet_id           = var.subnet_id
  tags                = var.tags
  custom_network_interface_name = var.custom_network_interface_name

  private_service_connection {
    name                           = var.psc_name   # EXACT live value
    private_connection_resource_id =  local.cosmos_account_id_normalized
    subresource_names              = ["Sql"] # Cosmos SQL API
    is_manual_connection           = false
  }
  # No private_dns_zone_group here as Azure Policy attaches it automatically

lifecycle {
  ignore_changes = [
    private_dns_zone_group,
    private_dns_zone_configs,
    custom_dns_configs,
  ]
}
}
