
# resource "aws_route53_zone" "internal-wmax641-website" {
#   name = "internal.wmax641.website"
#   vpc {
#     vpc_id = aws_vpc.main.id
#   }
#   tags = merge({ "Name" = "internal.wmax641.website" }, var.common_tags)
# }

# resource "aws_route53_record" "proxy-internal-wmax641-website" {
#   zone_id = aws_route53_zone.internal-wmax641-website.zone_id
#   name    = "proxy"
#   type    = "A"
#   ttl     = 300
#   records = ["10.13.37.42"]
# }
