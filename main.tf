module "s3_backend" {
  source = "./modules/s3-backend"
  bucket_name = "terraform-state-bucket-asya"
  table_name  = "terraform-locks"
}
