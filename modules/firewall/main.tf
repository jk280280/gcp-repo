resource "google_compute_firewall" "default" {
  name    = "default-allow-http"
  network = var.network
  allow {
    protocol = "tcp"
    ports    = ["80"]
  }
  source_ranges = ["0.0.0.0/0"]
}

variable "network" {
  description = "The network to apply the firewall rule to"
}
