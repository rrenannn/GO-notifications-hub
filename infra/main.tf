provider "google" {
  project = var.project_id
  region  = var.region
}

# 1. Este bloco liga a API do Cloud Run no seu projeto
resource "google_project_service" "cloudrun_api" {
  project = var.project_id
  service = "run.googleapis.com"
  disable_on_destroy = false
}

resource "google_cloud_run_service" "default" {
  name     = var.service_name
  location = var.region

  # 2. Isso garante que o Terraform espere a API ligar ANTES de criar o serviço
  depends_on = [google_project_service.cloudrun_api]

  template {
    spec {
      containers {
        image = var.image
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}

# Allow unauthenticated access (standard for public APIs/Hubs)
resource "google_cloud_run_service_iam_member" "public_access" {
  location = google_cloud_run_service.default.location
  project  = google_cloud_run_service.default.project
  service  = google_cloud_run_service.default.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}
