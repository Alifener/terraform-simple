
resource "aws_autoscaling_policy" "frontier_cpu_policy" {
  name                   = "frontier-cpu-policy"
  autoscaling_group_name = "${aws_autoscaling_group.prod_autoscaling_fronttier.name}"
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = "1"
  cooldown               = "300"
  policy_type            = "SimpleScaling"
}

resource "aws_cloudwatch_metric_alarm" "frontier_cpu_alarm" {
  alarm_name          = "frontier-cpu-alarm"
  alarm_description   = "frontier-cpu-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "80"

  dimensions = {
    "AutoScalingGroupName" = "${aws_autoscaling_group.prod_autoscaling_fronttier.name}"
  }

  actions_enabled = true
  alarm_actions   = ["${aws_autoscaling_policy.frontier_cpu_policy.arn}"]
  alarm_description   = "Frontier autoscale group cpu so high so It will scale up with one machine"
}

# scale down alarm
resource "aws_autoscaling_policy" "frontier_cpu_policy_scaledown" {
  name                   = "frontier-cpu-policy-scaledown"
  autoscaling_group_name = "${aws_autoscaling_group.prod_autoscaling_fronttier.name}"
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = "-1"
  cooldown               = "300"
  policy_type            = "SimpleScaling"
}

resource "aws_cloudwatch_metric_alarm" "frontier_cpu_alarm_scaledown" {
  alarm_name          = "frontier-cpu-alarm-scaledown"
  alarm_description   = "frontier-cpu-alarm-scaledown"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "10"

  dimensions = {
    "AutoScalingGroupName" = "${aws_autoscaling_group.prod_autoscaling_fronttier.name}"
  }

  actions_enabled = true
  alarm_actions   = ["${aws_autoscaling_policy.frontier_cpu_policy_scaledown.arn}"]
}
