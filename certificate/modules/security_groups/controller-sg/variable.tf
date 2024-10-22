variable "vpc_id" {}
# variable "ssh_ip_address" {}
# variable "vpc_cidr" {}
variable "vpc_cidr_blocks" {

}

# variable "private_zone1_010" {

# }
# variable "private_zone2_1610" {

# }
variable "member_sec_id" {

}

variable "rules" {
  type = set(object({
    from_port = number
    to_port   = number
    protocol  = string

  }))

  default = [
    {
      from_port = 53
      to_port   = 53
      protocol  = "tcp"
    },
    {
      from_port = 53
      to_port   = 53
      protocol  = "udp"
    },
    {
      from_port = 135
      to_port   = 135
      protocol  = "tcp"
    },
    {
      from_port = 0
      to_port   = 0
      protocol  = "icmp"
    },
    {
      from_port = 49152
      to_port   = 65535
      protocol  = "tcp"
    },
    {
      from_port = 49152
      to_port   = 65535
      protocol  = "udp"
    },
    {
      from_port = 137
      to_port   = 137
      protocol  = "udp"
    },

    {
      from_port = 88
      to_port   = 88
      protocol  = "tcp"
    },
    {
      from_port = 88
      to_port   = 88
      protocol  = "udp"
    },
    {
      from_port = 389
      to_port   = 389
      protocol  = "tcp"
    },
    {
      from_port = 389
      to_port   = 389
      protocol  = "udp"
    },
    {
      from_port = 445
      to_port   = 445
      protocol  = "tcp"
    },
    {
      from_port = 445
      to_port   = 445
      protocol  = "udp"
    },

    {
      from_port = 3269
      to_port   = 3269
      protocol  = "tcp"
    },
    {
      from_port = 464
      to_port   = 464
      protocol  = "udp"
    },
    {
      from_port = 464
      to_port   = 464
      protocol  = "tcp"
    },
    {
      from_port = 138
      to_port   = 138
      protocol  = "udp"
    },
    {
      from_port = 5355
      to_port   = 5355
      protocol  = "udp"
    },
    {
      from_port = 139
      to_port   = 139
      protocol  = "tcp"
    },

    {
      from_port = 636
      to_port   = 636
      protocol  = "tcp"
    },
    {
      from_port = 9389
      to_port   = 9389
      protocol  = "tcp"
    },
    {
      from_port = 123
      to_port   = 123
      protocol  = "udp"
    },
    {
      from_port = 3268
      to_port   = 3268
      protocol  = "tcp"
    },
    {
      from_port = 5722
      to_port   = 5722
      protocol  = "tcp"
    }
  ]
}
