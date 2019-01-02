

# https://www.terraform.io/docs/providers/aws/r/lambda_function.html

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
  function_name    = "index.js"
  role             = "${aws_iam_role.iam_for_lambda.arn}"
  handler          = "exports.test"
  source_code_hash = "${base64sha256(file("files.zip"))}"
  runtime          = "nodejs8.10"

  environment {
    variables = {
      foo = "bar"
    }
  }
}

# https://www.terraform.io/docs/providers/archive/d/archive_file.html

data "archive_file" "init" {
  type        = "zip"
  source_file = "files/index.js"
  output_path = "files.zip"
}

