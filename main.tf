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
  roles      = ["${aws_iam_role.Lambdaexecutionpolicy.name}"]
  policy_arn = "${aws_iam_policy.LambdaBasicExecutionPolicy.arn}"
}

resource "aws_iam_policy_attachment" "Lambdaexecutionpolicy1" {
  name       = "Lambdaexecutionrole"
  roles      = ["${aws_iam_role.Lambdaexecutionpolicy.name}"]
  policy_arn = "${aws_iam_policy.LambdaSecretsPolicy.arn}"
}

resource "aws_iam_policy_attachment" "TransferCanReadApi1" {
  name       = "TransferCanReadApi"
  roles      = ["${aws_iam_role.TransferIdentityProviderRole.name}"]
  policy_arn = "${aws_iam_policy.TransferCanReadThisApi.arn}"
}

resource "aws_iam_policy_attachment" "TransferCanReadApi" {
  name       = "TransferCanReadApi"
  roles      = ["${aws_iam_role.TransferIdentityProviderRole.name}"]
  policy_arn = "${aws_iam_policy.TransferCanInvokeThisApi.arn}"
}

resource "aws_lambda_function" "GetUserConfigLambda1" {
  role             = "${aws_iam_role.Lambdaexecutionpolicy.arn}"
  handler          = "lambda.handler"
  runtime          = "python3.7"
  filename         = "lambda.zip"
  function_name    = "GetUserConfigLambda"
source_code_hash = filebase64sha256("lambda.zip")
}

resource "aws_api_gateway_rest_api" "example" {
  name        = "ServerlessExample"
  description = "Terraform Serverless Application Example"
 endpoint_configuration {
    types = ["REGIONAL"]
}
}
resource "aws_api_gateway_resource" "proxy" {
  rest_api_id = "${aws_api_gateway_rest_api.example.id}"
  parent_id   = "${aws_api_gateway_rest_api.example.root_resource_id}"
  path_part = "{server}"
}
resource "aws_api_gateway_method" "proxy" {
  rest_api_id   = "${aws_api_gateway_rest_api.example.id}"
  resource_id   = "${aws_api_gateway_resource.proxy.id}"
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "lambda" {
  rest_api_id = "${aws_api_gateway_rest_api.example.id}"
  resource_id = "${aws_api_gateway_method.proxy.resource_id}"
  http_method = "${aws_api_gateway_method.proxy.http_method}"

  integration_http_method = "GET"
  type                    = "AWS_PROXY"
  uri                     = "${aws_lambda_function.GetUserConfigLambda1.invoke_arn}"
}


resource "aws_lambda_permission" "apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.GetUserConfigLambda1.function_name}"
  principal     = "apigateway.amazonaws.com"

  # More: http://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-control-access-using-iam-policies-to-invoke-api.html
  source_arn = "arn:aws:execute-api:ap-south-1:547155362487:${aws_api_gateway_rest_api.example.id}/*/${aws_api_gateway_method.proxy.http_method}${aws_api_gateway_resource.proxy.path}"
}
