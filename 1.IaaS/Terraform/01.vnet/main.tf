locals {
  # account_id   = data.aws_caller_identity.current.account_id

  project_id   = "eks"
  env          = "stg"
  region       = "koreacentral"
  location     = "Korea Central"
  cluster_name = "eks-${local.env}-${local.region}-eks-cluster"
  servicetitle = "test"

  # vpc cidr block list   in vpc resource 
  vpc_cidr = "192.168.36.128/26"

  # vpc cidr block list for aws_vpc_ipv4_cidr_block_association
  vpc_cidrs = [
    "100.64.8.0/24", "100.64.34.96/28", "100.64.0.0/22"
  ]

  # cidr block lists for subnet 
  public_dup_frontend_subnet       = "100.64.8.0/24"
  private_uniq_backend_subnet      = "100.64.34.96/28"
  private_dup_back_subnet          = "100.64.0.0/22"
  private_db_backend_subnet        = "192.168.36.128/26"
  
  # aws_azs = ["ap-northeast-2a", "ap-northeast-2c"]

  public_dup_frontend_subnet_name  = "snet-public-dup-frontend"
  private_uniq_backend_subnet_name = "snet-private-uniq-backend"
  private_dup_backend_subnet_name  = "snet-private-dup-backend"
  private_db_backend_subnet_name   = "snet-private-db-backend"
}