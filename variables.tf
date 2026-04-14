variable "resource_group_name" {
  description = "Name of the resource group where relay resources will be created"
  type        = string
}

variable "location" {
  description = "Azure region for the relay resources"
  type        = string
}

variable "container_app_environment_id" {
  description = "ID of the pre-provisioned Container Apps environment (must be linked to a Log Analytics workspace)"
  type        = string
}

variable "org_token" {
  description = "Organization token for authenticating the relay with the Conduiter API"
  type        = string
  sensitive   = true
}

variable "relay_name" {
  description = "Unique name for this relay instance (used in resource naming and identification)"
  type        = string
}

variable "api_endpoint" {
  description = "URL of the Conduiter API that the relay will connect to"
  type        = string
  default     = "https://api.conduiter.com"
}

variable "image" {
  description = "Container image for the relay"
  type        = string
  default     = "public.ecr.aws/y8p4n9c1/relay:latest"
}

variable "cpu" {
  description = "CPU cores allocated to the relay container"
  type        = number
  default     = 1.0
}

variable "memory" {
  description = "Memory allocated to the relay container (e.g. '2Gi')"
  type        = string
  default     = "2Gi"
}

variable "min_replicas" {
  description = "Minimum number of relay replicas for auto-scaling"
  type        = number
  default     = 1
}

variable "max_replicas" {
  description = "Maximum number of relay replicas for auto-scaling"
  type        = number
  default     = 3
}
