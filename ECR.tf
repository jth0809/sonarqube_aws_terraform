resource "aws_ecr_repository" "sonarqube" {
  name                 = "sonarqube"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
  encryption_configuration {
    encryption_type = "kms"
    kms_key         = aws_kms_key.sonarqube_key.arn
  }
}