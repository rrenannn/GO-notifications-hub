variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "The GCP region"
  type        = string
  default     = "us-central1"
}

variable "service_name" {
  description = "The name of the Cloud Run service"
  type        = string
  default     = "go-notifications-hub"
}

variable "image" {
  description = "The container image to deploy"
  type        = string
  default     = "gcr.io/cloudrun/hello" # Defaulting to a sample image
}
