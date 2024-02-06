### Data

data "google_compute_image" "image" {
  family  = "ubuntu-minimal-2204-lts"
  project = "ubuntu-os-cloud"
}

# import static ip
resource "google_compute_address" "static_ip" {
  name = var.name_vm
}

# Firewall
resource "google_compute_firewall" "allow_http_https" {
  name    = "allow-http-https"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  source_ranges = ["0.0.0.0/0"]
}

### Virtual Machine

resource "google_compute_instance" "default" {

  name         = var.name_vm
  machine_type = "e2-micro"
  zone         = "us-central1-a"

  tags = ["foo", "bar"]

  boot_disk {
    initialize_params {
      image = data.google_compute_image.image.self_link
      labels = {
        my_label = "value"
      }
    }
  }

  # network settings
  network_interface {
    network = "default"
    access_config {
      nat_ip = google_compute_address.static_ip.address
    }
  }

  metadata = {
    # create ssh key
    ssh-keys = "root:${file("~/.ssh/id_rsa.pub")}"
  }

  # start init.sh on vm
  metadata_startup_script = file("scripts/init.sh")
}

### Database cloud

resource "google_sql_database" "database" {
  name     = "test-database"
  instance = google_sql_database_instance.instance.name
}

resource "google_sql_database_instance" "instance" {
  name             = "my-database-instance"
  region           = "us-central1"
  database_version = "MYSQL_8_0"
  settings {
    tier = "db-f1-micro"
  }
  deletion_protection  = "false"
}