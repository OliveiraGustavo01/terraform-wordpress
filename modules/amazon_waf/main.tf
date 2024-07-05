resource "aws_wafv2_web_acl" "WAF-wp-rule-allow" {
  name        = var.web_acl_name
  description = "Firewall to Wordpress Application"
  scope       = "CLOUDFRONT"

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "WAFMetrics-wp" # Nome da métrica no CloudWatch
    sampled_requests_enabled   = true
  }

  default_action {
    allow {}
  }

  rule {
    name     = "AdminProtection"
    priority = 1

    override_action {
      count {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesAdminProtectionRuleSet"
        vendor_name = "AWS"

      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "WAFMetrics-wp" # Nome da métrica no CloudWatch
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "AmazonIPReputationList"
    priority = 2

    override_action {
      count {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesAmazonIpReputationList"
        vendor_name = "AWS"

      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "WAFMetrics-wp" # Nome da métrica no CloudWatch
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "LinuxOperatingSystem"
    priority = 3

    override_action {
      count {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesLinuxRuleSet"
        vendor_name = "AWS"

      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "WAFMetrics-wp" # Nome da métrica no CloudWatch
      sampled_requests_enabled   = true
    }

  }

  rule {
    name     = "SQLDatabase"
    priority = 4

    override_action {
      count {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesSQLiRuleSet"
        vendor_name = "AWS"
      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "WAFMetrics-wp" # Nome da métrica no CloudWatch
      sampled_requests_enabled   = true
    }
  }

  rule {
    name     = "WordPressApplication"
    priority = 5

    override_action {
      count {}
    }

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesWordPressRuleSet"
        vendor_name = "AWS"

      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = true
      metric_name                = "WAFMetrics-wp" # Nome da métrica no CloudWatch
      sampled_requests_enabled   = true
    }
  }

}