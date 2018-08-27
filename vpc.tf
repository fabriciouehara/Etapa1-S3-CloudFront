resource "aws_vpc" "VPC_Terraform" {
  cidr_block        = "10.20.0.0/16"
  instance_tenancy  = "default"

  tags {
    Name = "VPC_Terraform"
    Location = "N. Virginia"
  }
}

resource "aws_subnet" "subnet1" {
  vpc_id     = "${aws_vpc.VPC_Terraform.id}"
  cidr_block = "10.20.0.0/24"

  tags {
    Name = "Subnet1"
  }
}