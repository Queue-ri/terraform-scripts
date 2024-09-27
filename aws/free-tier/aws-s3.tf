# S3 설정
resource "aws_s3_bucket" "integrated-server-bucket" {
    bucket = "qriosity-integrated-server"
}