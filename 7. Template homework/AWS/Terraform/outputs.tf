#===========================================================================================-
# Rainbow Gravity's Template homework
# 
# Outputs
#===========================================================================================

output "Available_zones" {
  value = data.aws_availability_zones.Available.names
}
output "Current_region" {
  value = data.aws_region.Current.name
}

output "Current_bucket" {
  value = local.S3_Bucket_Name
}
output "Current_bucket_name" {
  value = aws_s3_bucket.VPC_Server_Files_Bucket.bucket
}
output "User_data" {
  value = templatefile("templates/web-server.tpl", {
    region = data.aws_region.Current.name
    bucket = local.S3_Bucket_Name
  })
}

output "Load_Balancer_DNS_name" {
  value = aws_lb.VPC_Load_Balancer.dns_name
}
