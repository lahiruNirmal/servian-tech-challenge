resource "aws_eip" "natgw_eip" {
  vpc      = true
  depends_on = [aws_internet_gateway.igw]
}