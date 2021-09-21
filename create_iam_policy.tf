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

resource "aws_iam_policy" "LambdaBasicExecutionPolicy" {
  name        = "LambadaBasicExecutionPolicy"
  description = "LambadaBasicExecutionPolicy"
  policy      = "${file("LambdaBasicExecutionPolicy.json")}"
}

resource "aws_iam_policy" "LambdaSecretsPolicy" {
  name        = "LambdaSecretsPolicy"
  description = "LambdaSecretsPolicy "
  policy      = "${file("LambdaSecretsPolicy.json")}"
}

resource "aws_iam_policy" "TransferCanInvokeThisApi" {
  name        = "TransferCanInvokeThisApi"
  description = "TransferCanInvokeThisApi"
  policy      = "${file("TransferCanInvokeThisApi.json")}"
}

resource "aws_iam_policy" "TransferCanReadThisApi" {
  name        = "TransferCanReadThisApi"
  description = "TransferCanReadThisApi"
  policy      = "${file("TransferCanReadThisApi.json")}"
}
