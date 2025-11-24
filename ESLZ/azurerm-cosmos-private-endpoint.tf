# All fields required; must be set in cosmos-pe.tfvars
variable "cosmos_pe" {
  description = "Settings for the Cosmos DB Private Endpoint (subnet looked up by name)."
  type = object({
    # Where to place the Private Endpoint NIC
    rg_name   = string
    location  = string
    pe_name   = string
    tags      = map(string)

    # Subnet lookup (existing VNet/subnet; we do NOT create it)
    vnet_rg_name = string
    vnet_name    = string
    subnet_name  = string
  })
}

# Look up the existing subnet by names
data "azurerm_subnet" "pe" {
  name                 = var.cosmos_pe.subnet_name
  virtual_network_name = var.cosmos_pe.vnet_name
  resource_group_name  = var.cosmos_pe.vnet_rg_name
}

module "cosmos_pe" {
  source     = "github.com/GoCHarrbra/terraform-azurerm-cosmos-private-endpoint.git?ref=v0.4.0"
  depends_on = [module.cosmos]  # ensure the Cosmos account exists first

  # Private Endpoint placement
  rg_name   = var.cosmos_pe.rg_name
  location  = var.cosmos_pe.location
  pe_name   = var.cosmos_pe.pe_name
  subnet_id = data.azurerm_subnet.pe.id
  tags      = var.cosmos_pe.tags

  # Target Cosmos account (from your Cosmos module) otherwise use var.
  cosmos_account_id = module.cosmos.cosmos_account_id
  psc_name          = var.cosmos_pe.psc_name
}

# Pass through module outputs
output "pe_id" {
  description = "Resource ID of the created Private Endpoint."
  value       = module.cosmos_pe.pe_id
}

output "pe_name" {
  description = "Name of the created Private Endpoint."
  value       = module.cosmos_pe.pe_name
}
