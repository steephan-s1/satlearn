provider "aws" {
shared_credentials_file  = "~/.aws/credentials"
  region     = "eu-west-2"
}
resource "aws_iam_policy_attachment" "ApiGatewayLogsPolicy" {
  name       = "ApiCloudWatchRole"
  roles      = ["${aws_iam_role.ApiCloudWatchLogsRole.name}"]
  policy_arn = "${aws_iam_policy.ApiGatewayLogsPolicy.arn}"
}

resource "aws_iam_policy_attachment" "TransferLogPolicy" {
  name       = "CloudWatchLoggingRole"
  roles      = ["${aws_iam_role.CloudWatchLoggingRole.name}"]
  policy_arn = "${aws_iam_policy.TransferLogPolicy.arn}"
}

resource "aws_iam_policy_attachment" "Lambdaexecutionpolicy" {
  name       = "Lambdaexecutionrole"
  roles      = ["${aws_iam_role.LambdaExcutionRole.name}"]
  policy_arn = "${aws_iam_policy.LambadaBasicExecutionPolicy.arn}"
  policy_arn = "${aws_iam_policy.LambdaSecretsPolicy.arn}"
}

resource "aws_lambda_function" "GetUserConfigLambda" {
  role             = "${aws_iam_role.need to create.arn}"
  handler          = "lambda.handler"
  runtime          = "python3.7"
  filename         = "lambda.zip"
  function_name    = "GetUserConfigLambda"
  source_code_hash = "${file("index.py")}"
}

