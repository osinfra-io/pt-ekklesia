# Local Values
# https://opentofu.org/docs/language/values/locals

locals {
  backstage_helm_values = file("${path.module}/helm/backstage.yml")

  datadog_mci_synthetic_url          = module.core_helpers.environment == "production" ? "https://gcp.osinfra.io/${local.datadog_synthetic_service}/metadata/cluster-name" : "https://${module.core_helpers.env}.gcp.osinfra.io/${local.datadog_synthetic_service}/metadata/cluster-name"
  datadog_synthetic_message_critical = module.core_helpers.environment == "production" ? "@hangouts-Platform-CriticalHighPriority" : ""
  datadog_synthetic_message_medium   = module.core_helpers.environment == "production" ? "@hangouts-Platform-MediumLowInfoPriority" : ""
  datadog_synthetic_name             = "Backstage"
  datadog_synthetic_service          = "backstage"

  datadog_synthetic_tests = module.core_helpers.region == "us-east1" || module.core_helpers.zone == "b" ? {
    "us-east1" = {
      locations = [
        "aws:us-east-1",
        "aws:us-east-2",
        "aws:us-west-1",
        "aws:us-west-2"
      ]

      message          = local.datadog_synthetic_message_medium
      message_priority = "3"
      name             = "Istio Ingress ${local.datadog_synthetic_name}"
      region           = module.core_helpers.region
      request_headers  = module.core_helpers.region == "global" ? {} : { Body = "services-${module.core_helpers.region}" }
      service          = local.datadog_synthetic_service
      status           = "paused"
      url              = module.core_helpers.environment == "production" ? "https://backstage.gcp.osinfra.io" : "https://backstage.${module.core_helpers.env}.gcp.osinfra.io"
    }
  } : {}

  github_app_private_key = base64decode(var.github_app_private_key)

  helm_values = [
    for k, v in local.helm_values_map : {
      name  = k
      value = v
    }
  ]

  helm_values_map = {
    "backstage.appConfig.app.title"                      = var.backstage_app_config_app_title
    "backstage.appConfig.app.baseUrl"                    = var.backstage_app_config_base_url
    "backstage.appConfig.backend.baseUrl"                = var.backstage_app_config_base_url
    "backstage.appConfig.backend.cors.origin"            = var.backstage_app_config_base_url
    "backstage.extraContainers[0].args[2]"               = "${data.google_project.shared_vpc_host.project_id}:${module.core_helpers.region}:${module.cloud_sql.instance}"
    "backstage.image.registry"                           = local.registry
    "backstage.image.tag"                                = var.backstage_version
    "backstage.podLabels.tags\\.datadoghq\\.com/env"     = module.core_helpers.environment
    "backstage.podLabels.tags\\.datadoghq\\.com/version" = var.backstage_version
    "backstage.replicas"                                 = var.backstage_replicas
    # "backstage.resources.limits.cpu"                     = var.backstage_resources_limits_cpu
    # "backstage.resources.limits.memory"                  = var.backstage_resources_limits_memory
    # "backstage.resources.requests.cpu"                   = var.backstage_resources_requests_cpu
    # "backstage.resources.requests.memory"                = var.backstage_resources_requests_memory
  }

  hostname           = module.core_helpers.environment == "production" ? "backstage-${module.core_helpers.region}.gcp.osinfra.io" : "backstage-${module.core_helpers.region}.${module.core_helpers.env}.gcp.osinfra.io"
  kubernetes_project = module.core_helpers.environment == "sandbox" ? "plt-k8s-tf39-sb" : module.core_helpers.environment == "production" ? "plt-k8s-tf10-prod" : "plt-k8s-tf33-nonprod"
  main               = data.terraform_remote_state.main.outputs
  managed_zone       = module.core_helpers.environment == "production" ? "gcp-osinfra-io" : "${module.core_helpers.env}-gcp-osinfra-io"
  registry           = module.core_helpers.environment == "sandbox" ? "us-docker.pkg.dev/plt-lz-services-tf7f-sb/plt-docker-virtual" : "us-docker.pkg.dev/plt-lz-services-tf79-prod/plt-docker-virtual"
}
