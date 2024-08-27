resource "google_compute_http_health_check" "http_check" {
  name               = "http-health-check"
  request_path       = "/"
  port               = 80
  check_interval_sec = 10
  timeout_sec        = 5
  healthy_threshold   = 2
  unhealthy_threshold = 2
}

resource "google_compute_url_map" "url_map" {
  name            = "url-map"
  default_service = var.backend_service
}

resource "google_compute_target_http_proxy" "http_proxy" {
  name    = "http-proxy"
  url_map = var.url_map
}

resource "google_compute_global_forwarding_rule" "http_forwarding_rule" {
  name       = "http-forwarding-rule"
  target     = var.target_http_proxy
  port_range = "80"
  ip_address = var.global_address
}

resource "google_compute_global_address" "http_lb_ip" {
  name = "http-lb-ip"
}

variable "backend_service" {
  description = "The self-link of the backend service"
}

variable "url_map" {
  description = "The self-link of the URL map"
}

variable "target_http_proxy" {
  description = "The self-link of the target HTTP proxy"
}

variable "global_address" {
  description = "The self-link of the global address"
}

output "global_address" {
  value = google_compute_global_address.http_lb_ip.address
}

output "health_check" {
  value = google_compute_http_health_check.http_check.self_link
}

output "url_map" {
  value = google_compute_url_map.url_map.self_link
}

output "target_http_proxy" {
  value = google_compute_target_http_proxy.http_proxy.self_link
}

output "forwarding_rule" {
  value = google_compute_global_forwarding_rule.http_forwarding_rule.self_link
}
