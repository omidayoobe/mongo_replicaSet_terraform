provider "aws" {
  region = "${var.my_region}"     # aws region - ireland
  # access_key = "{env.AWS_ACCESS_KEY_ID}"    # aws access key
  # secret_key ="{env.AWS_SECRET_ACCESS_KEY}" # aws secret key
}

# AWS resource for aws instance - ################# First instance
resource "aws_instance" "db_instance1" {   # the instance and the name of the Instance
  ami = "${var.my_ami}"     # ami grabbed from the variable file
  associate_public_ip_address = true
  instance_type = "t2.micro" # instance type = t2.micro
  key_name = "DevOpsEngineering3637"
  subnet_id = "${aws_subnet.private-subnet-db.id}"  # the subnet for the instance created below
  vpc_security_group_ids = ["${aws_security_group.db-security-group.id}"]   # the vpc security group created below
  tags = {          # tag
    Name = "mongo-db1"
  }
}

################################# DB Virtual machine 2 #######################################

# AWS resource for aws instance - ################# First instance
resource "aws_instance" "db2_instance" {   # the instance and the name of the Instance
  ami = "${var.my_ami}"     # ami grabbed from the variable file
  associate_public_ip_address = true
  key_name = "DevOpsEngineering3637"
  instance_type = "t2.micro" # instance type = t2.micro
  subnet_id = "${aws_subnet.private-subnet-db.id}"  # the subnet for the instance created below
  vpc_security_group_ids = ["${aws_security_group.db-security-group.id}"]   # the vpc security group created below
  tags = {          # tag
    Name = "mongo-db2"
  }
}

################################# DB Virtual machine 3 #######################################

# AWS resource for aws instance - ################# First instance
resource "aws_instance" "db3_instance" {   # the instance and the name of the Instance
  ami = "${var.my_ami}"     # ami grabbed from the variable file
  associate_public_ip_address = true
  key_name = "DevOpsEngineering3637"
  instance_type = "t2.micro" # instance type = t2.micro
  subnet_id = "${aws_subnet.private-subnet-db.id}"  # the subnet for the instance created below
  vpc_security_group_ids = ["${aws_security_group.db-security-group.id}"]   # the vpc security group created below
  tags = {          # tag
    Name = "mongo-db3"
  }
}

# AWS resource - private subnet
resource "aws_subnet" "private-subnet-db" {
  vpc_id = "${var.mongo_vpc}" # we made a variable in the varibale file and called it here as it was repeating more than once.
  cidr_block = "10.0.1.0/24" #cidr block

  tags = {
    Name = "db-private-subnet"
  }
}

# AWS secuirty group for private subnet
resource "aws_security_group" "db-security-group" {
  name = "db-security-group"
  description = "security group for the db"
  vpc_id = "${var.mongo_vpc}"

# inbound traffic
  ingress {
    from_port = 0000         # range from 27017 is in the end we are listening on this port for the traffic that needs to come in
    to_port = 65535          # mongo is recieving traffic from 27017, the app will spin upo a port in 3500, so it tells them to go to 27017 but my port is 3500
    protocol = "tcp"
    cidr_blocks = "${var.cidr_block_number}"
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"

  }
  # outbound traffic
  egress {
    from_port = 1024        # the outbound so we want the outbound to go out from any port in the range from 1024 to 65535
    to_port = 65535         # so the app is saying that i am waiting for the traffic on 3500. so mongo recieve the traffic on 27017 and does something with it then sends it back to the app waiting on 3500
    protocol = "tcp"
    cidr_blocks = "${var.cidr_block_number}"
  }
  tags = {
    Name = "mongo-db-secuirty-group"
  }
}
