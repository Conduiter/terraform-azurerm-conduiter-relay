output "relay_name" {
  description = "Logical name of this relay (use this to wire daemons to the relay)"
  value       = var.relay_name
}

output "relay_fqdn" {
  description = "Fully qualified domain name of the relay's latest revision"
  value       = azurerm_container_app.relay.latest_revision_fqdn
}

output "relay_endpoint" {
  description = "WSS endpoint for the relay Container App"
  value       = "wss://${azurerm_container_app.relay.latest_revision_fqdn}"
}

output "relay_id" {
  description = "Resource ID of the relay Container App"
  value       = azurerm_container_app.relay.id
}
