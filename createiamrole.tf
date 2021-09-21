resource "aws_iam_role" "ApiCloudWatchLogsRole" {
  name               = "ApiCloudWatchLogsRole"
  assume_role_policy = "${file("ApiCloudWatchRole.json")}"
}

resource "aws_iam_role" "CloudWatchLoggingRole" {
  name               = "CloudWatchLoggingRole"
  assume_role_policy = "${file("CloudWatchLoggingRole.json")}"
}

resource "aws_iam_role" "Lambdaexecutionpolicy" {
  name               = "LambdaExcutionRole"
  assume_role_policy = "${file("LambdaExcutionRole.json")}"
}

resource "aws_iam_role" "TransferIdentityProviderRole" {
  name               = "TransferIdentityProviderRole"
  assume_role_policy = "${file("TransferIdentityProviderRole.json")}"
}
