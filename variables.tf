variable "rg_name" {
  description = "Name of the resource group where the Private Endpoint will be created."
  type        = string
}

variable "location" {
  description = "Azure region for the Private Endpoint (e.g., canadacentral)."
  type        = string
}

variable "pe_name" {
  description = "Private Endpoint name (e.g., cosmos-pe)."
  type        = string
}

variable "subnet_id" {
  description = "Full resource ID of the subnet that hosts the Private Endpoint NIC."
  type        = string

  # Optional sanity check: looks like a subnet resource ID
  validation {
    condition     = can(regex("^/subscriptions/[^/]+/resourceGroups/[^/]+/providers/Microsoft\\.Network/virtualNetworks/[^/]+/subnets/[^/]+$", var.subnet_id))
    error_message = "subnet_id must be a valid subnet resource ID."
  }
}

variable "cosmos_account_id" {
  description = "Resource ID of the Cosmos DB account to connect to (e.g., module.cosmos.account_id)."
  type        = string

  # Optional sanity check: looks like a Cosmos DB account ID
  validation {
    condition     = can(regex("^/subscriptions/[^/]+/resourceGroups/[^/]+/providers/Microsoft\\.DocumentDB/databaseAccounts/[^/]+$", var.cosmos_account_id))
    error_message = "cosmos_account_id must be a valid Cosmos DB account resource ID."
  }
}

variable "tags" {
  description = "Tags to apply to the Private Endpoint and related resources."
  type        = map(string)
  default     = {}
}
