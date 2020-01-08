provider "scaleway" {
  access_key      = "SCALEWAY_ACCESS_KEY"
  secret_key      = "SCALEWAY_SECRET_KEY"
  organization_id = "SCALEWAY_ORGANIZATION_ID"
  zone            = "fr-par-1"
  region          = "fr-par"
}

resource "scaleway_instance_ip" "public_ip" {}

resource "scaleway_instance_security_group" "www" {
  inbound_default_policy  = "drop"
  outbound_default_policy = "accept"

  inbound_rule {
    action = "accept"
    port   = "22"
  }

  inbound_rule {
    action = "accept"
    port   = "80"
  }

  inbound_rule {
    action = "accept"
    port   = "443"
  }
  
    inbound_rule {
    action = "accept"
    port   = "5222"
  }

  inbound_rule {
    action = "accept"
    port   = "9001"
  }

  inbound_rule {
    action = "accept"
    port   = "9050"
  }

  inbound_rule {
    action = "accept"
    port   = "9051"
  }
}

resource "scaleway_instance_server" "tor" {
  type  = "DEV1-S"
  image = "bac6cb94-85db-4fb8-a789-2ad8526be9d2"
  tags = [ "tor", "relay" ]
  ip_id = scaleway_instance_ip.public_ip.id
  enable_ipv6 = true
  security_group_id = scaleway_instance_security_group.www.id
}
