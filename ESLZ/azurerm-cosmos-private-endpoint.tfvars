cosmos_pe = {
  # Where to place the Private Endpoint NIC
  rg_name  = "RGName"
  location = "canadacentral"
  pe_name  = "cosmos-pe"

  # Existing network objects we only READ (lookup)
  vnet_rg_name = "RGName"
  vnet_name    = "VNetName"
  subnet_name  = "SubnetNAME"
}
