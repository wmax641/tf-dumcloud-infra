resource "aws_key_pair" "wmax641-battlestation-rsa" {
  key_name   = "wmax641@battlestation-rsa"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDe/8LNzdPa+jFglxAH3UVSL1aRbEA5tBHz1mLJ1RVcMX1BWtIDFGH154df1IcjSrcIUV8dhffpuPht1VUBM+Cjv/ZYH+qOIBK0LBJb1+YKiaBzquETD25FtYXU7pKSK0fjUZnv66skeUIiLHWmqkd2rq1xiLDn/NioavQOOPdkUXzrDROICcpSjO5O+W72w8CI2T5IicQsrMwQk+Q3mR4biz+jtTgZEXEfVk5CxdMHVU7QaQYtrzP7ZJJtzg+1AX9I9541cv2v23LTVGSHWb2IFLHxmZ+8Pdkw8g6WijeTnT/a0D5KCl+J2TorabK9STjUZ2U2FkeaKbLn3LC0nkUh wmax641@battlestation"

  tags = merge({ "Name" = "battlestation-rsa" }, var.common_tags)
}

resource "aws_key_pair" "wmax641-battlestation-ed25519" {
  key_name   = "wmax641@battlestation-ed25519"
  public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOAd72zRFvoH/TxG6dZP2hPmeIceuExhYvnfnbqJK7Wl wmax641@battlestation"

  tags = merge({ "Name" = "battlestation-ed25519" }, var.common_tags)
}
