data "aws_acm_certificate" "domain" {
  domain      = var.domain
  types       = ["AMAZON_ISSUED"]
  most_recent = true
}

resource "aws_cloudfront_distribution" "cloudfront-wp" {
  web_acl_id = var.web_acl_id
  origin {
    domain_name = var.target_origin_id #seu_elb_dns
    origin_id   = var.target_origin_id
    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "https-only" # CloudFront se comunicará com a origem usando o mesmo protocolo (HTTP ou HTTPS) que foi usado entre o cliente e o CloudFront.
      origin_ssl_protocols   = ["TLSv1"]
    }

  }

  enabled         = true
  is_ipv6_enabled = true
  comment         = "Configuração do CloudFront"

  # Configurando Comportamentos
  default_cache_behavior {
    target_origin_id       = var.target_origin_id
    viewer_protocol_policy = "allow-all" #QUANDO FOR USAR HTTPS MUDE PARA "redirect-to-https"
    allowed_methods        = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"]
    cached_methods         = ["GET", "HEAD", "OPTIONS", ]
    compress               = true


    forwarded_values {
      query_string = true
      cookies {
        forward = "all"
      }
      headers = local.behaviors_headers
    }
  }


  # Configurando Segurança
  # Nao precisa por ser o alb que vai mapear esse arquivo
  # default_root_object = "index.html"

   aliases = var.aliases


   viewer_certificate {
   cloudfront_default_certificate = true
    acm_certificate_arn      =  data.aws_acm_certificate.domain.id
    ssl_support_method       = "sni-only" #Versão do SSL
    minimum_protocol_version = "TLSv1.2_2021"
  }

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["US", "BR"]
    }
  }

}

locals {
  #behaviors_headers = ["CloudFront-Forwarded-Proto", "CloudFront-Is-Mobile-Viewer", "CloudFront-Is-Tablet-Viewer", "CloudFront-Is-Desktop-Viewer", "Host", "*"]
  behaviors_headers = ["*"]
}