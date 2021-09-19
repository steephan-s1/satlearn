resource "aws_lambda_function" "GetUserConfigLambda" {
  role             = "${aws_iam_role.need to create.arn}"
  handler          = "lambda.handler"
  runtime          = "python3.7"
  filename         = "lambda.zip"
  function_name    = "GetUserConfigLambda"
  source_code_hash = "${file("index.py")}"
}