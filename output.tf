# output ip addres
output "public_ip" {
  value = google_compute_address.static_ip.address
}

#
output "bucket_ip" {
  value = google_compute_global_address.website_ip.address
}