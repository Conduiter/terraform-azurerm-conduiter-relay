# Conduiter Relay - Azure Terraform Module

The Conduiter Relay accepts inbound WebSocket connections from sender daemons, validates session tokens, and pipes encrypted data between daemons. The relay never decrypts file content -- it acts purely as a secure transport layer between authenticated endpoints.

This module deploys the relay as an Azure Container App with external ingress on :443. WebSocket support is enabled by default via Container Apps' `transport = "auto"` setting, and the app auto-scales between `min_replicas` and `max_replicas`.

## Usage

```hcl
module "relay" {
  source  = "conduiter/conduiter-relay/azurerm"
  version = "~> 1.0"

  resource_group_name          = azurerm_resource_group.conduiter.name
  location                     = azurerm_resource_group.conduiter.location
  container_app_environment_id = azurerm_container_app_environment.conduiter.id

  org_token    = var.org_token
  relay_name   = "production"
  api_endpoint = "https://api.conduiter.com"
}
```

The Container Apps environment must be pre-provisioned and linked to a Log Analytics workspace -- container stdout/stderr logs flow there automatically with no extra wiring.

## Requirements

| Name | Version |
|------|---------|
| Terraform | >= 1.5 |
| azurerm provider | ~> 4.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| resource_group_name | Name of the resource group where relay resources will be created | `string` | n/a | yes |
| location | Azure region for the relay resources | `string` | n/a | yes |
| container_app_environment_id | ID of the pre-provisioned Container Apps environment (must be linked to a Log Analytics workspace) | `string` | n/a | yes |
| org_token | Organization token for authenticating the relay with the Conduiter API | `string` | n/a | yes |
| relay_name | Unique name for this relay instance | `string` | n/a | yes |
| api_endpoint | URL of the Conduiter API that the relay will connect to | `string` | `"https://api.conduiter.com"` | no |
| image | Container image for the relay | `string` | `"public.ecr.aws/y8p4n9c1/relay:latest"` | no |
| cpu | CPU cores allocated to the relay container | `number` | `1.0` | no |
| memory | Memory allocated to the relay container | `string` | `"2Gi"` | no |
| min_replicas | Minimum number of relay replicas | `number` | `1` | no |
| max_replicas | Maximum number of relay replicas | `number` | `3` | no |

## Outputs

| Name | Description |
|------|-------------|
| relay_name | Logical name of this relay |
| relay_fqdn | Fully qualified domain name of the relay's latest revision |
| relay_endpoint | WSS endpoint for the relay Container App |
| relay_id | Resource ID of the relay Container App |

See the [full documentation](https://app.conduiter.com/docs/getting-started/azure-setup) for detailed setup instructions.
