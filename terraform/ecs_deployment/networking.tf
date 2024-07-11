/* Create a network for the project */
#
# This code creates a VPC and a public subnet within.
#


# Setup a VPC for Jenkins project with a CIDR block
resource "aws_vpc" "main_vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = var.vpc_name
  }
}

# Define a public subnet in our VPC.
# Instances in this subnet will receive a public IP address on launch
# to allow direct Internet access, necessary for initial configuration
# and remote management.
resource "aws_subnet" "public_subnet" {
  vpc_id = aws_vpc.main_vpc.id
  # A CIDR block for subnet that must be within the VPC CIDR block
  cidr_block = var.public_subnet_cidr_block
  # Setting responsible for public IP assignment
  map_public_ip_on_launch = var.is_public_subnet_public
  tags = {
    # Name used to refer to this subnet from other TF modules/projects
    Name = var.public_subnet_name
  }
}

# Define a gateway for our VPC
# Gateway is needed to exchange traffic with the outside.
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    # This name can be used to refer to this IGW from other TF modules
    Name = var.internet_gateway_name
  }
}

# Create a public routing table for our VPC for traffic to/from
# outside and trough our new public gateway
resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    # The default route for all outgoing
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags = {
    Name = var.public_subnet_routing_table_name
  }
}

# Associate our public subnet with the public routing table
resource "aws_route_table_association" "rt_associate_public" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.route_table.id
}

# Security Group for specific traffic:
#  - SSH traffic for remote management.
#  - HTTPS traffic for secure Jenkins access.
# Security group is a sort of firewall.

resource "aws_security_group" "flask_http" {
  name        = var.security_group_name
  description = "Allow Jenkins and SSH traffic"
  vpc_id      = aws_vpc.main_vpc.id

  # # for SSH traffic
  # ingress {
  #   from_port   = var.ssh_port
  #   to_port     = var.ssh_port
  #   protocol    = "tcp"
  #   cidr_blocks = ["0.0.0.0/0"]
  # }

  # for HTTP traffic to the Flask App
  ingress {
    from_port   = var.flask_http_port
    to_port     = var.flask_http_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # typical entry for outgoing traffic with "any" (-1) protocol
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.security_group_name
  }
}
