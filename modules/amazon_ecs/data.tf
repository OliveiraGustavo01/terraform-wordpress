data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

data "aws_vpc" "vpc" {
  #id = "${var.vpc_id}"
  filter {
    name   = "tag-value"
    values = ["${var.vpc_name}"]
  }
  filter {
    name   = "tag-key"
    values = ["Name"]
  }
}

data "aws_subnet" "ecs_service_subnet_ids" {
  id = var.ecs_service_subnet_ids[0]
}

data "aws_iam_policy_document" "kms" {
  statement {
    sid    = "Enable IAM User Permissions"
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }
    actions   = ["kms:*"]
    resources = ["*"]
  }
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["logs.${data.aws_region.current.name}.amazonaws.com"]
    }
    actions = [
      "kms:Encrypt*",
      "kms:Decrypt*",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:Describe*"
    ]
    resources = ["*"]
    condition {
      test     = "ArnLike"
      variable = "kms:EncryptionContext:aws:logs:arn"
      values   = ["arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:*"]
    }
  }
}
data "aws_iam_policy_document" "ecs_task_trust" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

data "aws_iam_policy_document" "ecs_task_policy" {
  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    effect    = "Allow"
    resources = ["*"]
  }
  statement {
    actions   = ["secretsmanager:GetSecretValue"]
    effect    = "Allow"
    resources = ["*"]
  }
  statement {
    actions   = ["kms:Decrypt"]
    effect    = "Allow"
    resources = [aws_kms_key.wordpress.arn]
  }
}

resource "aws_iam_role" "ecs_task_role" {
  name               = var.role_name
  assume_role_policy = data.aws_iam_policy_document.ecs_task_trust.json
}

resource "aws_iam_policy" "ecs_task_policy" {
  name   = var.policy_name
  policy = data.aws_iam_policy_document.ecs_task_policy.json
}

resource "aws_iam_role_policy_attachment" "ecs_role_attachment" {
  role       = aws_iam_role.ecs_task_role.name
  policy_arn = aws_iam_policy.ecs_task_policy.arn
}
resource "aws_iam_role_policy_attachment" "ECR" {
  role       = aws_iam_role.ecs_task_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}
