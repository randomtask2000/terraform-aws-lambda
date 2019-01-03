variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_region" {}
variable "vpc_id" {}
variable "lambda_name" {
    type = "string"
    default = "test_lambda"
}
