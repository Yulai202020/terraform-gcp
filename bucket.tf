### Bucket

# create bucket
resource "google_storage_bucket" "website" {
  name     = "example-website-yulain"
  location = "US"
}

resource "google_storage_bucket_object" "static_site_src" {

  # name file
  name = var.file_upload_name
  # path to file
  source = var.file_upload_path
  bucket = google_storage_bucket.website.name
}

# rules bucket for all users 
resource "google_storage_bucket_access_control" "public_rule" {
  bucket = google_storage_bucket.website.name
  role   = "READER"
  entity = "allUsers"
}

resource "google_compute_global_address" "website_ip" {
  name = "website-lb-ip"
}

resource "google_compute_backend_bucket" "website-backend" {
  name        = "website-bucket"
  bucket_name = google_storage_bucket.website.name
  enable_cdn  = true
}

resource "google_compute_url_map" "website" {
  name            = "website-url-map"
  default_service = google_compute_backend_bucket.website-backend.self_link
  host_rule {
    hosts        = ["*"]
    path_matcher = "allpaths"
  }
  path_matcher {
    name            = "allpaths"
    default_service = google_compute_backend_bucket.website-backend.self_link
  }
}

resource "google_compute_target_http_proxy" "website" {
  name    = "website-target-proxy"
  url_map = google_compute_url_map.website.self_link
}

resource "google_compute_global_forwarding_rule" "default" {
  name                  = "forwarding-rule"
  target                = google_compute_target_http_proxy.website.id
  load_balancing_scheme = "EXTERNAL"
  ip_address            = google_compute_global_address.website_ip.address
  ip_protocol           = "TCP"
  port_range            = 80
}