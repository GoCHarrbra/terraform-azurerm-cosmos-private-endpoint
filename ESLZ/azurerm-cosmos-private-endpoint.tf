# All fields required; must be set in cosmos-pe.tfvars
variable "cosmos_pe" {
  description = "Settings for the Cosmos DB Private Endpoint (subnet looked up by name)."
  type = object({
    # Where to place the Private Endpoint NIC
    rg_name   = string
    location  = string
    pe_name   = string

    # Subnet lookup (existing VNet/subnet; we do NOT create it)
    vnet_rg_name = string
    vnet_name    = string
    subnet_name  = string
  })
}

# Look up the existing subnet by names (Option B)
data "azurerm_subnet" "pe" {
  name                 = var.cosmos_pe.subnet_name
  virtual_network_name = var.cosmos_pe.vnet_name
  resource_group_name  = var.cosmos_pe.vnet_rg_name
}

module "cosmos_pe" {
  source     = "github.com/GoCHarrbra/terraform-azurerm-cosmos-private-endpoint.git?ref=v0.1.0"
  depends_on = [module.cosmos]  # ensure the Cosmos account exists first

  # Private Endpoint placement
  rg_name   = var.cosmos_pe.rg_name
  location  = var.cosmos_pe.location
  pe_name   = var.cosmos_pe.pe_name

  # Pass the resolved subnet ID from the data source
  subnet_id = data.azurerm_subnet.pe.id

  # Target Cosmos account (from your Cosmos module)
  cosmos_account_id = module.cosmos.account_id
}

# Match module outputs exactly
output "pe_id" {
  description = "Resource ID of the created Private Endpoint."
  value       = module.cosmos_pe.pe_id
}

output "pe_name" {
  description = "Name of the created Private Endpoint."
  value       = module.cosmos_pe.pe_name
}
