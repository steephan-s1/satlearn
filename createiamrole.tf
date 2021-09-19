resource "aws_iam_role" "ApiCloudWatchLogsRole" {
  name               = "ApiCloudWatchLogsRole"
  assume_role_policy = "${file("ApiCloudWatchRole.json")}"
}

resource "aws_iam_role" "CloudWatchLoggingRole" {
  name               = "CloudWatchLoggingRole"
  assume_role_policy = "${file("CloudWatchLoggingRole.json")}"
}

resource "aws_iam_role" "LambdaExcutionRole" {
  name               = "LambdaExcutionRole"
  assume_role_policy = "${file("LambdaExcutionRole.json")}"
}