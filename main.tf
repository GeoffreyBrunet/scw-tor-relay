provider "scaleway" {
  access_key      = "SCWK9Z9ZMHXTFD8ZEGPK"
  secret_key      = "642ab7c4-e2ec-4dbb-8b01-a72735a6071d"
  organization_id = "af42f501-9877-4a22-b224-925614cbd7fc"
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
}

resource "scaleway_instance_server" "tor" {
  type  = "DEV1-S"
  image = "ubuntu-bionic"
  tags = [ "tor" ]
  ip_id = scaleway_instance_ip.public_ip.id
  security_group_id = scaleway_instance_security_group.www.id
}