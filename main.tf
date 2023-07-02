#criando recurso aws_s3_bucket, inserindo um nome para o bucket e inserindo tags
resource "aws_s3_bucket" "my-new-bucket" {
  bucket = "my-tf-new-bucket-01"

  tags = {
    Name        = "My first Terraform with AWS"
    Envirioment = "Dev"
    ManegedBy   = "Danilo L"
    UpdatedAt   = "2023/07/02"
  }
}
#atribuindo as propriedades do bucket para profiles da conta do proprietario
resource "aws_s3_bucket_ownership_controls" "my-bucket-ownership-controls" {
  bucket = aws_s3_bucket.my-new-bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}
#definindo controle do bucket apenas para profiles da conta do proprietário
resource "aws_s3_bucket_acl" "my-bucket-acl" {
  depends_on = [aws_s3_bucket_ownership_controls.my-bucket-ownership-controls]

  bucket = aws_s3_bucket.my-new-bucket.id
  acl    = "private"
}