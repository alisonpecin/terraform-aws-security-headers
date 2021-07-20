provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "local" {
    path = "relative/path/to/terraform.tfstate"
  }
}

data "archive_file" "apply_security_headers" {
  type        = "zip"
  source_file = "./lambda_function.js"
  output_path = "./lambda_function.zip"
}

resource "aws_lambda_function" "apply_security_headers" {
  filename         = "./lambda_function.zip"
  function_name    = var.lambda_function_name
  role             = aws_iam_role.short_url_lambda_iam.arn
  handler          = "lambda_function.handler"
  source_code_hash = data.archive_file.apply_security_headers.output_base64sha256
  runtime          = var.lambda_runtime
  memory_size      = var.lambda_memory_size
  timeout          = var.lambda_timeout
  publish          = true
}

resource "aws_lambda_permission" "short_url_lambda_permssion_apply_security_headers_edgelambda" {
  statement_id  = "AllowExecutionFromCloudFront"
  action        = "lambda:GetFunction"
  function_name = aws_lambda_function.apply_security_headers.arn
  principal     = "edgelambda.amazonaws.com"
}
resource "aws_lambda_permission" "short_url_lambda_permssion_apply_security_headers_lambda" {
  statement_id  = "AllowExecutionFromCloudFront2"
  action        = "lambda:GetFunction"
  function_name = aws_lambda_function.apply_security_headers.arn
  principal     = "lambda.amazonaws.com"
}

resource "aws_iam_role" "short_url_lambda_iam" {
  name               = "short_url_lambda_iam"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": [
          "lambda.amazonaws.com",
          "edgelambda.amazonaws.com"
        ]
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "short_url_lambda_policy" {
  name = "short_url_lambda_policy"
  role = aws_iam_role.short_url_lambda_iam.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Stm1",
      "Effect": "Allow",
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*"
    },
    {
      "Sid": "Stm2",
      "Effect": "Allow",
      "Action": [
        "lambda:GetFunction"
      ],
      "Resource": "${aws_lambda_function.apply_security_headers.arn}:*"
    }
  ]
}
EOF
}
