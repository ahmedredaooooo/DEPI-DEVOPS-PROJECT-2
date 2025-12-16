resource "kubernetes_service" "backend_lb" {
  metadata {
    name = "backend-service"
  }

  spec {
    selector = {
      app = "backend"
    }
    type = "LoadBalancer"

    port {
      port        = 80         # External port
      target_port = 80       # Backend container port
    }
  }
}
