# Set the variable value in *.tfvars file
# or using -var="do_token=..." CLI option
variable "do_token" {}

# Configure the DigitalOcean Provider
provider "digitalocean" {
  token = "${var.do_token}"
}

# Create a web server
resource "digitalocean_droplet" "web" {
    image = "ubuntu-18-04-x64"
    name = "superfluous"
    region = "nyc3"
    size = "s-1vcpu-1gb"
}