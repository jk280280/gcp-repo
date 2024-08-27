provider "google" {
  project = var.project_id
  region  = var.region
}

module "instance_template" {
  source      = "./modules/instance_template"
  region      = var.region
  startup_script = file("data/startup-script.sh")
}

module "instance_group" {
  source             = "./modules/instance_group"
  instance_template  = module.instance_template.self_link
  region             = var.region
  zone               = var.zone
}

module "load_balancer" {
  source              = "./modules/load_balancer"
  region              = var.region
  backend_service     = module.instance_group.backend_service
  health_check        = module.load_balancer.health_check
  url_map             = module.load_balancer.url_map
  target_http_proxy   = module.load_balancer.target_http_proxy
  forwarding_rule    = module.load_balancer.forwarding_rule
  global_address     = module.load_balancer.global_address
}

module "firewall" {
  source    = "./modules/firewall"
  network   = "default"
}

output "instance_group_manager" {
  value = module.instance_group.instance_group_manager
}

output "load_balancer_ip" {
  value = module.load_balancer.global_address
}

variable "project_id" {
  description = "The ID of the GCP project"
}

variable "region" {
  description = "The region for the resources"
}

variable "zone" {
  description = "The zone for the instance group"
}
