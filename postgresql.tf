resource "azurerm_postgresql_server" "postserver" {
  name                = "postgresql-server-1"
  location            = "${azurerm_resource_group.azureresourcegroup.location}"
  resource_group_name = "${azurerm_resource_group.azureresourcegroup.name}"

  sku_name = "B_Gen5_2"

  storage_profile {
    storage_mb            = 5120
    backup_retention_days = 7
    geo_redundant_backup  = "Disabled"
  }

  administrator_login          = var.administrator_login1
  administrator_login_password = var.administrator_login_password1
  version                      = "9.5"
  ssl_enforcement              = "Enabled"
}

resource "azurerm_postgresql_database" "postsqldb" {
  name                = "exampledb"
  resource_group_name = "${azurerm_resource_group.azureresourcegroup.name}"
  server_name         = "${azurerm_postgresql_server.postserver.name}"
  charset             = "UTF8"
  collation           = "English_United States.1252"
}
