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


# s3 read permission 

resource "aws_iam_policy" "db_artifact_read" {

  name = "${var.project_name}-db-artifact-read"

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Action = [
          "s3:GetObject"
        ]

        Resource = "${aws_s3_bucket.db_artifacts.arn}/*"
      }
    ]
  })
}