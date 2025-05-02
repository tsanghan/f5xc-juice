##########################################
#              _               _
#   ___  _   _| |_ _ __  _   _| |_
#  / _ \| | | | __| '_ \| | | | __|
# | (_) | |_| | |_| |_) | |_| | |_
#  \___/ \__,_|\__| .__/ \__,_|\__|
#                 |_|
##########################################
output "instance" {
  value = aws_instance.juice
}

output "eip" {
  value = aws_eip.juice
}

output "hc_name" {
    value = try(module.health_check.health_check_name, null)
}