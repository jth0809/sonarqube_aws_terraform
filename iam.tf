resource "aws_iam_role" "SonarQubeTaskRole" {
  name = "SonarQubeTaskRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      },
    ]
  })
}
resource "aws_iam_role" "SonarQubeTaskExecutionRole" {
  name = "SonarQubeTaskExecutionRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      },
    ]
  })
  managed_policy_arns = [ "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly", "arn:aws:iam::aws:policy/AWSOpsWorksCloudWatchLogs" ]
  inline_policy {
    name = "sonarqube-task"
    policy = jsonencode({
        Version = "2012-10-17"
        "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "kms:Decrypt",
                "secretsmanager:GetSecretValue"
            ],
            "Resource": [
                "arn:aws:kms:ap-northeast-2: <aws id numbers> :key/<key id>",
                "arn:aws:secretsmanager:ap-northeast-2: <aws id numbers> :secret:rds!cluster-<rds cluster id>"
            ]
        }
        ]
    })
  }
}