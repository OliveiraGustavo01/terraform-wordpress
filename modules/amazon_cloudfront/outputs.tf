output "arn" {
  value = aws_cloudfront_distribution.cloudfront-wp.arn
}

output "hostedzone_id" {
  value = aws_cloudfront_distribution.cloudfront-wp.hosted_zone_id
}