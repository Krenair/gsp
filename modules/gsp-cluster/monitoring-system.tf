data "aws_iam_policy_document" "cloudwatch_log_shipping_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals = {
      type        = "AWS"
      identifiers = ["${aws_iam_role.kiam_server_role.arn}"]
    }
  }
}

data "aws_iam_policy_document" "cloudwatch_log_shipping_policy" {
  statement {
    effect = "Allow"

    actions = [
      "logs:DescribeLogGroups",
    ]

    resources = ["*"]
  }

  statement {
    effect = "Allow"

    actions = [
      "logs:DescribeLogStreams",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    resources = ["${aws_cloudwatch_log_group.logs.arn}"]
  }
}

resource "aws_iam_role" "cloudwatch_log_shipping_role" {
  name = "${var.cluster_name}_cloudwatch_log_shipping_role"

  assume_role_policy = "${data.aws_iam_policy_document.cloudwatch_log_shipping_role.json}"
}

resource "aws_iam_policy" "cloudwatch_log_shipping_policy" {
  name        = "${var.cluster_name}_cloudwatch_log_shipping_policy"
  description = "Send logs to Clouwatch"

  policy = "${data.aws_iam_policy_document.cloudwatch_log_shipping_policy.json}"
}

resource "aws_iam_policy_attachment" "cloudwatch_log_shipping_policy" {
  name       = "${var.cluster_name}_cloudwatch_log_shipping_role_policy_attachement"
  roles      = [
    "${aws_iam_role.cloudwatch_log_shipping_role.name}",
    "${module.k8s-cluster.kiam-server-node-instance-role-name}",
  ]
  policy_arn = "${aws_iam_policy.cloudwatch_log_shipping_policy.arn}"
}

resource "aws_cloudwatch_log_group" "logs" {
  name              = "${var.cluster_domain}"
  retention_in_days = 30
}
