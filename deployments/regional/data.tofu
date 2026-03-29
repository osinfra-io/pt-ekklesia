# Google Client Config Data Source
# https://search.opentofu.org/provider/hashicorp/google/latest/docs/data-sources/client_config

data "google_client_config" "default" {}

# Google Container Cluster Data Source
# https://search.opentofu.org/provider/hashicorp/google/latest/docs/data-sources/container_cluster

data "google_container_cluster" "this" {
  location = module.core_helpers.region
  name     = "plt-${module.core_helpers.region}-${module.core_helpers.zone}"
  project  = data.google_project.kubernetes.project_id
}

# Google Project Data Source
# https://search.opentofu.org/provider/hashicorp/google/latest/docs/data-sources/project

data "google_project" "kubernetes" {
  project_id = data.google_projects.kubernetes.projects.0.project_id
}

data "google_project" "shared_vpc_host" {
  project_id = data.google_projects.shared_vpc_host.projects.0.project_id
}

# Google Projects Data Source
# https://search.opentofu.org/provider/hashicorp/google/latest/docs/data-sources/projects

data "google_projects" "kubernetes" {
  filter = "name:plt-k8s-* labels.env:${module.core_helpers.environment}"
}

data "google_projects" "shared_vpc_host" {
  filter = "name:plt-backstage-* labels.env:${module.core_helpers.environment}"
}

# OpenTofu Remote State Data Source
# https://opentofu.org/docs/language/state/remote-state-data

data "terraform_remote_state" "main" {
  backend = "gcs"

  config = {
    bucket             = var.remote_bucket
    kms_encryption_key = var.state_kms_encryption_key
    prefix             = module.core_helpers.repository
  }

  workspace = "main-${module.core_helpers.environment}"
}
