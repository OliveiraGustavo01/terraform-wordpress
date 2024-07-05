[
  {
    "name": "${ecs_service_container_name}",
    "image": "484537504486.dkr.ecr.us-east-1.amazonaws.com/wordpress-hub-seara:latest",
    "portMappings": [
      {
        "containerPort": 80,
        "protocol": "tcp"
      }
    ],
    "secrets": [{
      "name": "WORDPRESS_DB_PASSWORD",
      "valueFrom": "arn:aws:secretsmanager:${aws_region}:${aws_account_id}:secret:${secret_name}:WORDPRESS_DB_PASSWORD::"
    },
    {
      "name": "WORDPRESS_DB_HOST",
      "valueFrom": "arn:aws:secretsmanager:${aws_region}:${aws_account_id}:secret:${secret_name}:WORDPRESS_DB_HOST::"
    },
    {
      "name": "WORDPRESS_DB_USER",
      "valueFrom": "arn:aws:secretsmanager:${aws_region}:${aws_account_id}:secret:${secret_name}:WORDPRESS_DB_USER::"
    },
    {
      "name": "WORDPRESS_DB_NAME",
      "valueFrom": "arn:aws:secretsmanager:${aws_region}:${aws_account_id}:secret:${secret_name}:WORDPRESS_DB_NAME::"
    }],
    "logConfiguration": { 
      "logDriver": "awslogs",
      "options": { 
        "awslogs-group" : "${cloudwatch_log_group}",
        "awslogs-region": "${aws_region}",
        "awslogs-stream-prefix": "wordpress"
      }
    }, 
    "mountPoints": [
      {
        "readOnly": false,
        "containerPath": "/var/www/html",
        "sourceVolume": "wordpress"
      }
    ]
  }
]
