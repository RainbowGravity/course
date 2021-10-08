#===========================================================================================
# Rainbow Gravity's Template homework
# 
# S3 Buckets
#===========================================================================================

resource "aws_s3_bucket" "VPC_Server_Files_Bucket" {
  bucket = local.S3_Bucket_Name
  acl    = "private"
  tags   = merge(var.Tags, { Name = "${var.Tags["Environment"]} VPC Server Files" })
}

resource "aws_s3_bucket_object" "VPC_Upload" {
  bucket = aws_s3_bucket.VPC_Server_Files_Bucket.id
  key    = "index.html"
  acl    = "private"
  source = "files/index.html"
  etag   = filemd5("files/index.html")
}

resource "aws_s3_bucket" "VPC_Server_Secret_Bucket" {
  bucket = local.S3_Secret_Bucket_Name
  acl    = "authenticated-read"
  tags   = merge(var.Tags, { Name = "${var.Tags["Environment"]} VPC Server Secrets" })
}

resource "aws_s3_bucket_object" "VPC_Secrets" {
  bucket = aws_s3_bucket.VPC_Server_Secret_Bucket.id
  key    = "ssh/${local.SSH_Instances_Key}.pem"
  acl    = "private"
  source = "~/.ssh/${local.SSH_Instances_Key}.pem"
}
