resource "azurerm_mssql_server" "mcitsqlserv" {
  name                         = "mcitsqlserver"
  resource_group_name          = azurerm_resource_group.azureresourcegroup.name
  location                     = azurerm_resource_group.azureresourcegroup.location
  version                      = "12.0"
  administrator_login          = var.administrator_login
  administrator_login_password = var.administrator_login_password
}

resource "azurerm_mssql_database" "test" {
  name           = "acctest-db-d"
  server_id      = azurerm_mssql_server.mcitsqlserv.id
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  license_type   = "LicenseIncluded"
  max_size_gb    = 4
  read_scale     = true
  sku_name       = "S0"
  zone_redundant = true

  tags = {
    foo = "bar"
  }
}
