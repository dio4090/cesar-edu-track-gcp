# main.tf

# Configuração do provedor Google Cloud
provider "google" {
  project = var.project_id
  region  = var.region
}

# Definição das variáveis
variable "project_id" {
  description = "O ID do seu projeto no GCP"
  type        = string
  default     = "cesar-edu-track"
}

variable "region" {
  description = "A região onde os recursos serão criados"
  type        = string
  default     = "us-central1"
}

# Criação de um bucket no Cloud Storage
resource "google_storage_bucket" "bucket" {
  name                        = "cesar-edu-track-dw-cs"
  location                    = var.region
  force_destroy               = true
  uniform_bucket_level_access = true

  versioning {
    enabled = true
  }
}

# Criação de um dataset no BigQuery
resource "google_bigquery_dataset" "dataset" {
  dataset_id                  = replace("cesar-edu-track_sdt", "-", "_")
  location                    = var.region
  project                     = var.project_id
  friendly_name               = "alunos"
  description                 = "Dataset de alunos POC com Vanna AI"
  default_table_expiration_ms = 3600000  # 1 hora
}
