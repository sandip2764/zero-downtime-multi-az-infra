# only db secret 

resource "aws_iam_policy" "secrets_read" {

  name = "${var.project_name}-secrets-read"

  policy = jsonencode({

    Version = "2012-10-17"

    Statement = [

      {

        Effect = "Allow"

        Action = [

          "secretsmanager:GetSecretValue",

          "secretsmanager:DescribeSecret"

        ]

        Resource = var.db_secret_arn

      }

    ]

  })

}