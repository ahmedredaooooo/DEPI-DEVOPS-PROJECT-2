resource "kubernetes_secret" "db_secret" {
  metadata {
    name = "db-secret"
  }

  data = {
    DB_PASSWORD = base64encode(var.db_password)
  }
}

resource "kubernetes_deployment" "backend" {
  metadata {
    name = "backend-deployment"
    labels = {
      app = "backend"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "backend"
      }
    }

    template {
      metadata {
        labels = {
          app = "backend"
        }
      }

      spec {
        container {
          name  = "backend"
          image = "public.ecr.aws/t5z8k5y0/backend-api:v1"

          port {
            container_port = 80
          }

          env {
            name  = "DB_HOST"
            value = "depi-postgres.ca7qsgck2wny.us-east-1.rds.amazonaws.com"
          }
          env {
            name  = "DB_PORT"
            value = "5432"
          }
          env {
            name  = "DB_NAME"
            value = "depi-postgres"
          }
          env {
            name  = "DB_USER"
            value = "appuser"
          }
          env {
            name  = "DB_PASSWORD"
            value_from {
              secret_key_ref {
                name = kubernetes_secret.db_secret.metadata[0].name
                key  = "DB_PASSWORD"
              }
            }
          }
        }
      }
    }
  }
}
