resource "helm_release" "cert-manager" {
  name       = "cert-manager"
  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"
  version    = var.chart_version
  namespace = var.namespace
  create_namespace = true
  set {
    name = "crds.enabled"
    value = "true"
  }
}

resource "kubernetes_manifest" "cluster_issuer" {
  count = var.create ? 1 : 0  
  
  depends_on = [helm_release.cert-manager]

  manifest = {
    apiVersion = "cert-manager.io/v1"
    kind       = "ClusterIssuer"
    metadata = {
      name = var.clusterIssuer_name
    }
    spec = {
      acme = {
        email  = var.letsencrypt_email
        server = var.acme_server_url
        privateKeySecretRef = {
          name = var.private_key_secret_name
        }
        solvers = [
          {
            http01 = {
              ingress = {
                ingressClassName = var.ingress_class
              }
            }
          }
        ]
      }
    }
  }
}
