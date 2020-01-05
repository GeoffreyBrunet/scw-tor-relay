output "Public_ip_tor" {
  value = "${scaleway_instance_server.tor.public_ip}"
}
output "Name_tor" {
  value = "${scaleway_instance_server.tor.name}"
}