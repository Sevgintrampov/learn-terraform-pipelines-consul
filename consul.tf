resource "helm_release" "consul" {
  count      = data.tfe_outputs.cluster.values.enable_consul_and_vault ? 1 : 0
  depends_on = [kubernetes_namespace.secrets]
  name       = "${var.release_name}-consul"
  repository = "https://helm.releases.hashicorp.com"
  chart      = "consul"
  namespace  = var.namespace

  set {
    name  = "global.name"
    value = "consul"
  }

  set {
    name  = "server.replicas"
    value = var.replicas
  }

  set {
    name  = "server.bootstrapExpect"
    value = var.replicas
  }
}