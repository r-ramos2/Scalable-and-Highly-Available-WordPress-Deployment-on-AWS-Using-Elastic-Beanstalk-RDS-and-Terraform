provider "aws" {
  region = var.region
}

resource "aws_elastic_beanstalk_application" "wordpress" {
  name = "wordpress-app"
}

resource "aws_elastic_beanstalk_environment" "wordpress_env" {
  application        = aws_elastic_beanstalk_application.wordpress.name
  name               = "wordpress-env"
  solution_stack_name = "64bit Amazon Linux 2 v3.3.6 running PHP 7.4"

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = aws_iam_instance_profile.eb_ec2_role.name
  }

  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "ServiceRole"
    value     = aws_iam_role.eb_service_role.arn
  }

  setting {
    namespace = "aws:rds:dbinstance"
    name      = "DBInstanceClass"
    value     = "db.t3.micro"
  }
}

resource "aws_db_instance" "wordpress_db" {
  allocated_storage   = 20
  engine              = "mysql"
  instance_class      = "db.t3.micro"
  name                = "wordpressdb"
  username            = "admin"
  password            = var.db_password
  multi_az            = true
  publicly_accessible = false
}

resource "aws_iam_role" "eb_service_role" {
  name = "aws-elasticbeanstalk-service-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Principal = {
        Service = "elasticbeanstalk.amazonaws.com"
      }
      Effect    = "Allow"
      Sid       = ""
    }]
  })
}

resource "aws_iam_instance_profile" "eb_ec2_role" {
  name = "aws-elasticbeanstalk-ec2-role"
  role = aws_iam_role.eb_service_role.name
}
