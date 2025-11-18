# All fields required; must be set in cosmos-pe.tfvars
variable "cosmos_pe" {
  description = "Settings for the Cosmos DB Private Endpoint."
  type = object({
    rg_name   = string          # kept for flexibility, but we’ll prefer module.cosmos outputs
    location  = string
    pe_name   = string          # e.g., "cosmos-pe"
    subnet_id = string          # full subnet ID for the PE NIC
  })

  # Optional sanity check on subnet_id
  validation {
    condition     = can(regex("^/subscriptions/[^/]+/resourceGroups/[^/]+/providers/Microsoft\\.Network/virtualNetworks/[^/]+/subnets/[^/]+$", var.cosmos_pe.subnet_id))
    error_message = "subnet_id must be a valid subnet resource ID."
  }
}

module "cosmos_pe" {
  source     = "github.com/GoCHarrbra/terraform-azurerm-cosmos-private-endpoint.git?ref=v0.1.0"
  depends_on = [module.cosmos]  # ensure Cosmos exists first

  # Prefer placement from foundation (module.cosmos), avoids drift vs tfvars
  rg_name           = module.cosmos.rg_name
  location          = module.cosmos.location

  pe_name           = var.cosmos_pe.pe_name
  subnet_id         = var.cosmos_pe.subnet_id

  # Target Cosmos account from foundation output
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
