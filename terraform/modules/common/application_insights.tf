resource "azurerm_application_insights" "main" {
  name                = "${var.prefix}aai"
  resource_group_name = data.azurerm_resource_group.main.name
  location            = data.azurerm_resource_group.main.location
  application_type    = "web"

  tags = {
    "hidden-link:${data.azurerm_resource_group.main.id}/providers/Microsoft.Web/sites/${var.prefix}afa": "Resource",
  }
}
