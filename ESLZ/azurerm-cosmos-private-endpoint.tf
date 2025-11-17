# All fields required; must be set in cosmos-pe.tfvars
variable "cosmos_pe" {
  description = "Settings for the Cosmos DB Private Endpoint."
  type = object({
    rg_name   = string
    location  = string
    pe_name   = string                    # e.g., "cosmos-pe"
    subnet_id = string                    # full subnet ID for the PE NIC
  })
}

module "cosmos_pe" {
  source     = "github.com/GoCHarrbra/terraform-azurerm-cosmos-private-endpoint.git?ref=v0.1.0"
  depends_on = [module.cosmos]            # ensure the Cosmos account exists in this stack

  rg_name           = var.cosmos_pe.rg_name
  location          = var.cosmos_pe.location
  pe_name           = var.cosmos_pe.pe_name
  subnet_id         = var.cosmos_pe.subnet_id
  cosmos_account_id = module.cosmos.account_id
}

output "pe_id" {
  description = "Resource ID of the created Private Endpoint."
  value       = module.cosmos_pe.pe_id
}

output "pe_name" {
  description = "Name of the created Private Endpoint."
  value       = module.cosmos_pe.pe_name
}
