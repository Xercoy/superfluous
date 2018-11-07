# Set the variable value in *.tfvars file
# or using -var="do_token=..." CLI option
variable "do_token" {}
variable "do_ssh_key_path" {}

# Configure the DigitalOcean Provider
provider "digitalocean" {
  token = "${var.do_token}"
}

resource "digitalocean_ssh_key" "default" {
  name       = "Terraform Example"
  public_key = "${var.do_ssh_key_path}"
}

# Create a web server
resource "digitalocean_droplet" "web" {
    image = "ubuntu-18-04-x64"
    name = "superfluous"
    region = "nyc3"
    size = "s-1vcpu-1gb"
    ssh_keys = ["${digitalocean_ssh_key.default.fingerprint}"]
}