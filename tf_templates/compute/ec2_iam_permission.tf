resource "aws_iam_role_policy" "secrets-access-policy" {
  name = "tech-challenge-secrets-access-policy"
  role = aws_iam_role.ec2-secret-role.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "secretsmanager:GetRandomPassword",
        "secretsmanager:GetResourcePolicy",
        "secretsmanager:GetSecretValue",
        "secretsmanager:DescribeSecret",
        "secretsmanager:ListSecretVersionIds",
        "secretsmanager:ListSecrets"
      ],
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Action": "ec2:*",
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": "elasticloadbalancing:*",
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": "cloudwatch:*",
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": "autoscaling:*",
      "Resource": "*"
    }
  ]
}
EOF

    tags = {
        Name = "tech-challenge-secrets-access-policy"
    }
}

resource "aws_iam_role" "ec2-secret-role" {
  name = "ec2-secret-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  tags = {
      Name = "tech-challenge-ec2-secret-role"
  }
}



resource "aws_iam_instance_profile" "ec2-iam-instance-profile" {
  name = "ec2-iam-instance-profile"
  role = aws_iam_role.ec2-secret-role.name

  tags = {
        Name = "tech-challenge-ec2-iam-instance-profile"
    }
}