resource "aws_iam_policy" "ApiGatewayLogsPolicy" {
  name        = "ApiGatewayLogsPolicy"
  description = "ApiGatewayLogsPolicy connect with ApiCloudWatchRole"
  policy      = "${file("ApiGatewayLogsPolicy.json")}"
}

resource "aws_iam_policy" "TransferLogPolicy" {
  name        = "TransferLogPolicy"
  description = "TransferLogPolicy "
  policy      = "${file("TransferLogPolicy.json")}"
}

resource "aws_iam_policy" "LambadaBasicExecutionPolicy" {
  name        = "LambadaBasicExecutionPolicy"
  description = "LambadaBasicExecutionPolicy"
  policy      = "${file("LambadaBasicExecutionPolicy.json")}"
}

resource "aws_iam_policy" "LambdaSecretsPolicy" {
  name        = "LambdaSecretsPolicy"
  description = "LambdaSecretsPolicy "
  policy      = "${file("LambdaSecretsPolicy.json")}"
}
