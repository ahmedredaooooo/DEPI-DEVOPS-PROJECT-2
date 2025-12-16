resource "kubernetes_deployment" "frontend" {
  metadata {
    name = "frontend-deployment"
    labels = {
      app = "frontend"
    }
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "frontend"
      }
    }

    template {
      metadata {
        labels = {
          app = "frontend"
        }
      }

      spec {
        container {
          name  = "frontend"
          image = "public.ecr.aws/t5z8k5y0/frontend-app:latest"

          port {
            container_port = 80
          }

                 }
      }
    }
  }
}
