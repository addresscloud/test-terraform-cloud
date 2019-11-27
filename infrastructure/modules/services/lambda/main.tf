// Hello world IAM
resource "aws_iam_role" "hello_world_terraform" {
  name               = "hello_world_terraform"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "logs.eu-west-1.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    },
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

}

resource "aws_iam_role_policy" "hello_world_terraform" {
  name   = "hello_world_terraform"
  role   = aws_iam_role.hello_world_terraform.name
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
        "Effect": "Allow",
        "Action": [
            "logs:*"
        ],
        "Resource": "arn:aws:logs:*:*:*"
    },
    {
      "Effect": "Allow",
      "Action": ["lambda:InvokeFunction"],
      "Resource": "*"
    },
  ]
}
EOF

}

// hello_world_terraform function package
data "archive_file" "hello_world_terraform" {
  type = "zip"
  source_file = "../../../../build/hello-world/index.js"
  output_path = "../../../../build/hello-world.zip"
}

// hello_world_terraform definition
resource "aws_lambda_function" "hello_world_terraform" {
  filename         = "../../../../build/hello-world.zip"
  source_code_hash = data.archive_file.hello_world_terraform.output_base64sha256
  function_name    = "addresscloud-hello_world_terraform_dev"
  role             = aws_iam_role.hello_world_terraform.arn
  handler          = "index.default"
  runtime          = "nodejs10.x"
  timeout          = "10"
  memory_size      = "128"
  publish          = true
  environment {
    variables = {
      DEBUG        = "true"
    }
  }
}
