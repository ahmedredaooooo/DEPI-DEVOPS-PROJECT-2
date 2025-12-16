data "aws_eks_cluster" "dev" {
  name = "dev-eks"
}

# Get auth token
data "aws_eks_cluster_auth" "dev" {
  name = data.aws_eks_cluster.dev.name
}



 provider  "kubernetes" {
  host                   = data.aws_eks_cluster.dev.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.dev.certificate_authority[0].data)
  token 		 = data.aws_eks_cluster_auth.dev.token
}


