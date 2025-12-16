data "terraform_remote_state" "network" {
  backend = "s3"

  config = {
    bucket = "dev-ops-terraform-state"   # S3 bucket where network state is stored
    key    = "global/terraform.tfstate"  # Path to the network state file in S3
    region = "us-east-1"                  # Region where the bucket exists
  }
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.16.0"

  cluster_name    = var.cluster_name
  cluster_version = "1.34"

  vpc_id     = data.terraform_remote_state.network.outputs.vpc_id
  subnet_ids = data.terraform_remote_state.network.outputs.private_subnets

  cluster_endpoint_public_access = true

  eks_managed_node_groups = {
    default = {
      name           = "default"
      instance_types = [var.node_instance_type]
      min_size       = 2
      max_size       = 3
      desired_size   = 2
    }
  }
}
