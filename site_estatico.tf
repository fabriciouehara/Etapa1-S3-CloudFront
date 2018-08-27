#Criação do bucket S3
resource "aws_s3_bucket" "bucket-fabricio" {
  bucket = "buckets3-terraform-fabricio"
  acl    = "public-read"

  website {
    index_document = "index.html"
    error_document = "error.html"
    
  }
}


#Upload do conteudo estatico no bucket s3
resource "aws_s3_bucket_object" "buckets3-terraform-index" {
  acl          = "public-read"
  key          = "index.html"
  bucket       = "${aws_s3_bucket.bucket-fabricio.id}"
  source       = "./index.html"
  content_type = "text/html"
  etag         = "${md5(file("./index.html"))}"
}

locals {
  s3_origin_id = "origin-terraform"
}

#Criação do cloudFront
resource "aws_cloudfront_distribution" "buckets3-terraform-distribution" {
  origin {
    domain_name = "${aws_s3_bucket.bucket-fabricio.bucket_domain_name}"
    origin_id   = "${local.s3_origin_id}"

  }

  
  enabled             = true
  is_ipv6_enabled     = true
  comment             = "Terraform CloudFrount"
  default_root_object = "index.html"
  
  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "${local.s3_origin_id}"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
	
    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  
  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["BR"]
    }
  }
  
  viewer_certificate {
    cloudfront_default_certificate = true
  }

}
