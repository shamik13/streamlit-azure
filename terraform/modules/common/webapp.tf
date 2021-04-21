resource "azurerm_app_service" "main" {
  name                       = "${var.prefix}awa"
  resource_group_name        = data.azurerm_resource_group.main.name
  location                   = data.azurerm_resource_group.main.location
  app_service_plan_id        = azurerm_app_service_plan.main.id

  app_settings = {
    APPINSIGHTS_INSTRUMENTATIONKEY      = azurerm_application_insights.main.instrumentation_key
    DOCKER_ENABLE_CI                    = true
    DOCKER_REGISTRY_SERVER_URL          = azurerm_container_registry.main.login_server
    DOCKER_REGISTRY_SERVER_USERNAME     = azurerm_container_registry.main.admin_username
    DOCKER_REGISTRY_SERVER_PASSWORD     = azurerm_container_registry.main.admin_password
    WEBSITES_ENABLE_APP_SERVICE_STORAGE = false
    PREFIX                              = var.prefix
  }  
  
  identity {
    type = "SystemAssigned"
  }

  site_config {
    always_on        = true
    linux_fx_version = "DOCKER|${azurerm_container_registry.main.login_server}/${var.docker_image}:${var.env}"
  }
}

resource "azurerm_container_registry_webhook" "main" {
  name                = "${var.prefix}acrw"
  resource_group_name = data.azurerm_resource_group.main.name
  location            = data.azurerm_resource_group.main.location
  registry_name       = azurerm_container_registry.main.name
  service_uri         = format("https://$%s:%s@%s.scm.azurewebsites.net/docker/hook", azurerm_app_service.main.name, azurerm_app_service.main.site_credential.0.password, azurerm_app_service.main.name)
  status              = "enabled"
  scope               = "${var.docker_image}:${var.env}"
  actions             = ["push"]
}
