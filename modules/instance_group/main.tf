resource "google_compute_instance_group_manager" "apache_mig" {
  name               = "apache-mig"
  version {
    instance_template = var.instance_template
  }
  base_instance_name = "apache-instance"
  target_size         = 2
  zone                = var.zone
}

resource "google_compute_backend_service" "backend_service" {
  name                  = "backend-service"
  backends {
    group = google_compute_instance_group_manager.apache_mig.instance_group
  }
  port_name              = "http"
  protocol               = "HTTP"
  timeout_sec            = 10
  connection_draining {
    draining_timeout_sec = 60
  }
}

variable "instance_template" {
  description = "The self-link of the instance template"
}

variable "region" {
  description = "The region where the resources will be created"
}

variable "zone" {
  description = "The zone where the instance group will be created"
}

output "backend_service" {
  value = google_compute_backend_service.backend_service.self_link
}

output "instance_group_manager" {
  value = google_compute_instance_group_manager.apache_mig.self_link
}
