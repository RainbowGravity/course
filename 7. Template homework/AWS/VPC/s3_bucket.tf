#===========================================================================================
# Rainbow Gravity's CloudFormation Template homework
# 
# S3 Bucket
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
