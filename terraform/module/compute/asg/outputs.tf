output "asg_id" {
  value = aws_autoscaling_group.this.id
}

output "asg_name" {
  value = aws_autoscaling_group.this.name
}

output "asg_arn" {
  value = aws_autoscaling_group.this.arn
}

output "asg_desired_capacity" {
  value = aws_autoscaling_group.this.desired_capacity
}

output "asg_min_size" {
  value = aws_autoscaling_group.this.min_size
}

output "asg_max_size" {
  value = aws_autoscaling_group.this.max_size
}