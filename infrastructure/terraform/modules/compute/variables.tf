variable "subnet_id" {
  type        = string
  description = "ID of the VPC subnet for the EC2 instances"
}

variable "website_sg_id" {
  type        = string
  description = "Website security group ID"
}

variable "mlserver_sg_id" {
  type        = string
  description = "ML server security group ID"
}
