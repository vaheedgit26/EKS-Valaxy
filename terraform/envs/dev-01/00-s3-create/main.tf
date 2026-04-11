# S3-MODULE Calling
module "s3" {
  source = "git::https://github.com/vaheedgit26/Infra//modules/s3" # Give the path to S3 MODULE accordingly

  s3_bucket_name = "tfstate-${var.project_name}-${var.env}-${var.region}"
  project_name   = var.project_name
  env            = var.env
  region         = var.region
}
