terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

resource "azurerm_container_app" "relay" {
  name                         = "conduiter-relay-${var.relay_name}"
  resource_group_name          = var.resource_group_name
  container_app_environment_id = var.container_app_environment_id
  revision_mode                = "Single"

  secret {
    name  = "org-token"
    value = var.org_token
  }

  template {
    min_replicas = var.min_replicas
    max_replicas = var.max_replicas

    container {
      name   = "relay"
      image  = var.image
      cpu    = var.cpu
      memory = var.memory

      env {
        name  = "CONDUITER_API_URL"
        value = var.api_endpoint
      }

      env {
        name  = "RELAY_NAME"
        value = var.relay_name
      }

      env {
        name  = "PORT"
        value = "8080"
      }

      env {
        name        = "ORG_TOKEN"
        secret_name = "org-token"
      }
    }
  }

  ingress {
    external_enabled = true
    target_port      = 8080
    transport        = "auto"

    traffic_weight {
      latest_revision = true
      percentage      = 100
    }
  }

  tags = {
    Name        = "conduiter-relay-${var.relay_name}"
    Environment = var.relay_name
    Service     = "relay"
  }
}
