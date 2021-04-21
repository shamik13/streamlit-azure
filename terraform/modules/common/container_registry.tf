resource "azurerm_container_registry" "main" {
  name                = "${var.prefix}acr"
  resource_group_name = data.azurerm_resource_group.main.name
  location            = data.azurerm_resource_group.main.location
  sku                 = "Premium"
  admin_enabled       = true
}

resource "null_resource" "docker-deploy" {

  triggers = {
    always_run = timestamp()
  }

  provisioner "local-exec" {
    command = "az acr login --name ${azurerm_container_registry.main.name}"
  }

  provisioner "local-exec" {
    command = "docker build -t ${azurerm_container_registry.main.login_server}/${var.docker_image}:${var.env} ../../../docker"
  }

  provisioner "local-exec" {
    command = "docker push ${azurerm_container_registry.main.login_server}/${var.docker_image}:${var.env}"
  }
}
