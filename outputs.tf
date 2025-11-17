output "pe_id" {
  description = "Resource ID of the created Private Endpoint."
  value       = azurerm_private_endpoint.cosmos_sql.id
}

output "pe_name" {
  description = "Name of the created Private Endpoint."
  value       = azurerm_private_endpoint.cosmos_sql.name
}
