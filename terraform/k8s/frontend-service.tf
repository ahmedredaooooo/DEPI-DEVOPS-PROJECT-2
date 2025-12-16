resource "kubernetes_service" "frontend_lb" {
  metadata {
    name = "frontend-service"
  }

  spec {
    selector = {
      app = "frontend"
    }
    type = "LoadBalancer"

    port {
      port        = 80
      target_port = 80
    }
  }
}
