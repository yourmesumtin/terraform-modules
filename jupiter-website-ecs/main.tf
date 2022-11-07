# configure aws provider
provider "aws" {
  region  = var.region
  profile = "terraform-user"
}

# create vpc
module "vpc" {
  source                       = "../modules/vpc"
  region                       = var.region
  project_name                 = var.project_name
  vpc_cidr                     = var.vpc_cidr
  public_subnet_az1_cidr       = var.public_subnet_az1_cidr
  public_subnet_az2_cidr       = var.public_subnet_az2_cidr
  private_app_subnet_az1_cidr  = var.private_app_subnet_az1_cidr
  private_app_subnet_az2_cidr  = var.private_app_subnet_az2_cidr
  private_data_subnet_az1_cidr = var.private_data_subnet_az1_cidr
  private_data_subnet_az2_cidr = var.private_data_subnet_az2_cidr
  domain_name                  = var.domain_name
  alternative_name             = var.alternative_name

}
# create nat gateways
module "nat_gateway" {
  source                     = "../modules/vpc/nat-gateway"
  public_subnet_az1_id       = module.vpc.public_subnet_az1_id
  internet_gateway           = module.vpc.internet_gateway
  public_subnet_az2_id       = module.vpc.public_subnet_az2_id
  vpc_id                     = module.vpc.vpc_id
  private_app_subnet_az1_id  = module.vpc.private_app_subnet_az1_id
  private_data_subnet_az1_id = module.vpc.private_data_subnet_az1_id
  private_app_subnet_az2_id  = module.vpc.private_app_subnet_az2_id
  private_data_subnet_az2_id = module.vpc.private_data_subnet_az2_id
}

# create security group
module "security_group" {
  source = "../modules/vpc/security-groups"
  vpc_id = module.vpc.vpc_id

}

# create ecs task execution
module "ecs_task_execution_role" {
  source       = "../modules/vpc/ecs-tasks-execution-role"
  project_name = module.vpc.project_name
}
# create AWS certificate manager
module "acm" {
  source           = "../modules/vpc/acm"
  domain_name      = var.domain_name
  alternative_name = var.alternative_name

}

# create application load balancer
module "application_load_balancer" {
  source                = "../modules/vpc/alb"
  project_name          = module.vpc.project_name
  alb_security_group_id = module.security_group.alb_security_group_id
  public_subnet_az1_id  = module.vpc.public_subnet_az1_id
  public_subnet_az2_id  = module.vpc.public_subnet_az2_id
  vpc_id                = module.vpc.vpc_id
  certificate_arn       = module.acm.certificate_arn
}




