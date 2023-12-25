resource "aws_kms_key" "sonarqube_key" {
  description = "sonarqube_key"
}

resource "aws_kms_key_policy" "sonarqube_key" {
  key_id = aws_kms_key.sonarqube_key.id
  policy = jsonencode({
    Id = "sonarqube-policy"
    Statement = [
      {
        Action = "kms:*"
        Effect = "Allow"
        Principal = {
          AWS = "*" #your iam arn
        }

        Resource = "*"
        Sid      = "Enable IAM User Permissions"
      },
    ]
    Version = "2012-10-17"
  })
}