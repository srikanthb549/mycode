###Following is the example for providing instance list in MAP variable format
resource "aws_instance" "instance" {
  for_each = var.ec2-instances
  ami                    = "ami-09c813fb71547fc4f"
  instance_type          = "t3.small"
  vpc_security_group_ids = ["sg-0781e11c5f22234f7"]
  tags = {
    Name = each.key
  }
}

variable "ec2-instances" {
  default = {
    production1 = {}
    production2 = {}
  }
}

resource "aws_route53_record" "route53" {
  for_each = var.ec2-instances
  name    = each.key
  type    = "A"
  zone_id = "Z08641142SH8HBQE1FAJT"
  ttl     = "30"
  records = [aws_instance.instance[each.key].private_ip]
}




###Following is the example for providing instance list in List variable format
# resource "aws_instance" "instance" {
#   count = length(var.ec2-instances)
#   ami                    = "ami-09c813fb71547fc4f"
#   instance_type          = "t3.small"
#   vpc_security_group_ids = ["sg-0781e11c5f22234f7"]
#   tags = {
#     Name = var.ec2-instances[count.index]
#   }
# }
#
# variable "ec2-instances" {
#   default = [
#     "qa1",
#     "qa2"]
# }
#
#
# resource "aws_route53_record" "route53" {
#   count = length(var.ec2-instances)
#   name    = var.ec2-instances[count.index]
#   type    = "A"
#   zone_id = "Z08641142SH8HBQE1FAJT"
#   ttl     = "30"
#   records = [aws_instance.instance[count.index].private_ip]
# }
