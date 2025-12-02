locals {
  cosmos_account_id_normalized = replace(
    var.cosmos_account_id,
    "Microsoft.DocumentDB",
    "Microsoft.DocumentDb"
  )
}