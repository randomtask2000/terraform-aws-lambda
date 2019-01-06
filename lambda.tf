

# https://www.terraform.io/docs/providers/aws/r/lambda_function.html

provider "aws" {
  region     = "${var.aws_region}"
}
resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_lambda_function" "test_lambda" {
  filename         = "files.zip"
  function_name    = "${var.lambda_name}"
  description      = "Test lambda provisioned by Terraform"
  role             = "${aws_iam_role.iam_for_lambda.arn}"
  handler          = "index.handler"
  source_code_hash = "${base64sha256(file("files.zip"))}"
  runtime          = "nodejs8.10"

  environment {
    variables = {
      foo = "bar"
    }
  }
}

# https://www.terraform.io/docs/providers/archive/d/archive_file.html
# and https://github.com/hashicorp/terraform/issues/8344
data "archive_file" "init" {
  type        = "zip"
  source_dir  = "files"
  output_path = "files.zip"
}

