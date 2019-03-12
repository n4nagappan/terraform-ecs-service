provider "aws" {
  region     = "${var.region}"
}

resource "aws_vpc" "terraform_vpc" {
  cidr_block       = "10.0.0.0/16"
  enable_dns_hostnames = true

  tags {
    Name = "Terraform"
  }
}

resource "aws_subnet" "public_1" {
  vpc_id     = "${aws_vpc.terraform_vpc.id}"
  cidr_block = "10.0.0.0/24"
  availability_zone = "${var.region}a"

  tags {
    Name = "Terraform Public Subnet"
  }
}

resource "aws_subnet" "public_2" {
  vpc_id     = "${aws_vpc.terraform_vpc.id}"
  cidr_block = "10.0.1.0/24"
  availability_zone = "${var.region}b"

  tags {
    Name = "Terraform Public Subnet"
  }
}

resource "aws_internet_gateway" "terraform_vpc_igw" {
  vpc_id = "${aws_vpc.terraform_vpc.id}"

  tags {
    Name = "Terraform - Internet Gateway"
  }
}

resource "aws_route_table" "terraform_route_table" {
  vpc_id = "${aws_vpc.terraform_vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.terraform_vpc_igw.id}"
  }

  tags {
    Name = "Public Subnet Route Table"
  }
}

resource "aws_route_table_association" "terraform_route_table_association_1" {
  subnet_id = "${aws_subnet.public_1.id}"
  route_table_id = "${aws_route_table.terraform_route_table.id}"
}

resource "aws_route_table_association" "terraform_route_table_association_2" {
  subnet_id = "${aws_subnet.public_2.id}"
  route_table_id = "${aws_route_table.terraform_route_table.id}"
}

resource "aws_key_pair" "terraform_key" {
  key_name   = "terraform"
  public_key = "${file("./ssh-keys/terraform.pub")}"
}
