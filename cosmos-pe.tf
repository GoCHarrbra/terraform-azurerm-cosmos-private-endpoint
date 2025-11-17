resource "azurerm_private_endpoint" "cosmos_sql" {
  name                = var.pe_name
  location            = var.location
  resource_group_name = var.rg_name
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = "${var.pe_name}-psc"
    private_connection_resource_id = var.cosmos_account_id
    subresource_names              = ["Sql"] # Cosmos SQL API
    is_manual_connection           = false
  }

  # No private_dns_zone_group here as Azure Policy attaches it automatically
}
