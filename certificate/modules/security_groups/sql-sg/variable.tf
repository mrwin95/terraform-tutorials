variable "vpc_id" {}
# variable "ssh_ip_address" {}
# variable "vpc_cidr" {}
variable "vpc_cidr_blocks" {

}

variable "rules" {
  type = set(object({
    from_port = number
    to_port   = number
    protocol  = string

  }))

  default = [
    {
      from_port = 3343
      to_port   = 3343
      protocol  = "tcp"
    },
    {
      from_port = 3343
      to_port   = 3343
      protocol  = "udp"
    },
    {
      from_port = 1434
      to_port   = 1434
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
      from_port = 137
      to_port   = 137
      protocol  = "tcp"
    },
    {
      from_port = 445
      to_port   = 445
      protocol  = "tcp"
    },
    {
      from_port = 5985
      to_port   = 5985
      protocol  = "tcp"
    },
    {
      from_port = 1433
      to_port   = 1434
      protocol  = "tcp"
    },
    {
      from_port = 5022
      to_port   = 5022
      protocol  = "tcp"
    }
  ]
}
