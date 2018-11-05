---
title: "#004: Terraformization"
date: 2018-11-03T21:18:58-07:00
---

Terraformization wasn't a word until now. Anyways...

So we have our web server and we have our Docker container that our web server is going to live in. 

Basically, we have the most basic software portion down, and now we're going to setup the 'computer' its going to run on.

In this project, I'll be using Terraform to create a Digital Ocean Droplet.

--- 

## Enter Terraform 

Terraform is a great tool for controlling and organizing infrastructure in a safe and efficient way. A few people I've worked with have used Digital Ocean to create droplets, AKA Virtual Private Servers. If you've done one already, think of Terraform this way: it's a means of being able to create and manipulate droplets via files.

Terraform is compatable with most infrastructure providers out there today such as Amazon Web Services, Google Cloud Platform, Digital Ocean, Netlify, Heroku, and much more. It's possible to write a plugin for Terraform for custom infrastructure too. (full list [here](https://www.terraform.io/docs/providers/index.html))

Interesting right? Software is organized as code too. Being able to make it such that Infrastructure can be organized in the same way is SUPER GREAT. 

No more 'this person needs to follow this article or read these instructions'. No more obscurity. Also, no more manual work! You can organize, share, and manipulate infrastructure the same way code is managed as files.

This whole thing about having files represent infrastructure configuration? There's a buzzword for that. **Infrastructure As Code**.

Think of how great things could be with Terraform and other technologies. From one simple command line action, we can:

- **setup the infrastructure (create a droplet)**
- prepare the infrastructure (update, download software/code)
- run the entire code test suite (automated testing)
- deploy the code to the server (automated deployment)

Terraform takes care of the first part. In an ideal project, when developing code, if we were to update the code and do a merge to master, we could:

- have the new code automatically tested 
- have the new code automatically deployed

See the introduction page [here](https://www.terraform.io/intro/index.html).

End Post here, Cue technical notes and stuffs...

---

## The Terraform File
This single Terraform file is used to create a single droplet. 

```
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
```

- Terraform needs the plugin code for the provider. `terraform init`

- `terraform validate` to validate a terraform file

- Terraform variables can be set as environment variables via the `TF_VAR_<variable name here>` prefix.

- Information about the state of resources provisioned by TF is held in a cache. That MUST be maintained and shared by all entities manipulating the resource, else the resource information must be imported, which is a pain.

### Links

- [Digital Ocean Documentation](https://developers.digitalocean.com/documentation/v2/#regions) - useful for finding out possible image names, resource names, etc. They're not really listed anywhere else it seems.

