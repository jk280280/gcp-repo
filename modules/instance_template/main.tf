resource "google_compute_instance_template" "apache_template" {
  name          = "apache-instance-template"
  machine_type  = "n1-standard-1"
  region        = var.region

  tags = ["http-server"]

  network_interface {
    network = "default"
    access_config {
      // Include this to get an external IP
    }
  }

  metadata_startup_script = var.startup_script

  disk {
    auto_delete = true
    boot        = true
    device_name = "boot"
    disk_size   = 10
    disk_type   = "pd-standard"

    initialize_params {
      image = "projects/debian-cloud/global/images/family/debian-11"
    }
  }
}

variable "region" {
  description = "The region for the instance template"
}

variable "startup_script" {
  description = "The startup script for the instances"
}
