#terraform {
#    required_version = "~> 0.13.5​"
#}

provider "aws" {
  region =  "us-east-2"
  profile = "Ulises"
}


resource "aws_instance" "bastion_host" {
    ami                     = "ami-0b614a5d911900a9b"
    instance_type           = "t2.micro"
    availability_zone       = "us-east-2a"
    subnet_id               = aws_subnet.public_subnet.id
    vpc_security_group_ids  = [aws_security_group.ssh.id]
    key_name = "testkey"

    tags = {
        Name = "bastion_host"
    }
}

resource "aws_instance" "linux_host" {
    ami                     = "ami-0b614a5d911900a9b"
    instance_type           = "t2.micro"
    availability_zone       = "us-east-2a"
    subnet_id               = aws_subnet.private_subnet.id
    vpc_security_group_ids  = [aws_security_group.ssh.id]
    key_name = "testkey"

    tags = {
        Name = "linux_host"
    }
}

##resource "aws_key_pair" "testkey" {
##    key_name    = "testkey"
##    public_key  = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDQ94LPDIpPi/hTlAoyk+LywubFk6au4QiW13n8iTNAyp7MaJlBwSE17uxfpfNEELzUwFPvEwl8uxucWUEZ7HkXxnMQcl7qQRnJDDINBwJga4p9FjbtJD/6Z3jK0OYQ8114WCDmNeRzmuDiJs7et7ExhewXqJ1eYJGMU9fgaGk2irQjNn/XMKIs5XS0+kCIKoN8zi51Ij5kTBva/d59xGXMP6a5KJlrdeqeDjqephDsmjZIXmCA4vZCKkaRnHC2cb01WQB5bZl1W6h+UtOSlFerhvhnywjxIwBW5+FRLz4SyHtz6cEZyJAPbsLp0JQ3slwp3q01r0GPew8XTeL4Ars3ePWnMONFb4btiOOoC3kkbz1tykUcW8y6JrHms39i94ND3BARUH1IYZE4AJZBZg+eJ0s5SZ9SosBC/XljdSkAsQy4GIm9zIoRiYRkApmRxAWrDq/hQoVp0W3KfxoH1LqzDZyksDVwW6X31keteefUyjQzO+/lXMMKa6XaYdO9cGM= ulises.rodriguez@C02GL18HMD6M"
##}