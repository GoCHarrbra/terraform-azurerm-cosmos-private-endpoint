cosmos_pe = {
  # Where to place the Private Endpoint NIC
  rg_name  = "RGName-Network"
  location = "canadacentral"
  pe_name  = "cosmos-pe"

  # Tags applied to the Private Endpoint
  tags = {
    owner    = "yours@your.com"
    purpose  = "app-data-private-endpoint"
    env      = "sand1"
    division = "DIV1"
  }

  # Existing network objects we only READ (lookup)
  vnet_rg_name = "RGName-Network"
  vnet_name    = "VNetName"
  subnet_name  = "SubnetNAME"

  psc_name = "livepscname"
  custom_network_interface_name = "livenicname"
}
