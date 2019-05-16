resource "aws_security_group" "voltdb_public" {
  name        = "voltdb_public"
  description = "Allow public traffic into ports 22, 5555, 8443, 80890, 21211, and 21212"
  vpc_id      = "${var.vpc_id}"

  # Public ports
  # SSH
  ingress {
    from_port   = "22"
    to_port     = "22"
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # XDCR
  ingress {
    from_port   = "5555"
    to_port     = "5555"
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
    
  # TLS
  ingress {
    from_port   = "8443"
    to_port     = "8443"
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  # HTTP
  ingress {
    from_port   = "8080"
    to_port     = "8080"
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Admin
  ingress {
  	from_port   = "21211"
    to_port     = "21211"
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  # Client
  ingress {
  	from_port   = "21212"
    to_port     = "21212"
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
      
  egress {
    from_port       = "0"
    to_port         = "0"
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
  
  tags = {
  	Name = "voltdb_public"
  }
}

# Private ports
resource "aws_security_group" "voltdb_private" {
  name        = "voltdb_private"
  description = "Allow subnet-only traffic on ports 3021"
  vpc_id      = "${var.vpc_id}"

  # Internal Server  
  ingress {
  	from_port   = "3021"
    to_port     = "3021"
    protocol    = "TCP"
    cidr_blocks = ["${split(";", var.private_cidr_blocks)}"]
  }
  
  tags = {
  	Name = "voltdb_private"
  }
}
