resource "aws_autoscaling_attachment" "asg_attachment" {
  autoscaling_group_name = aws_eks_node_group.eks_node_ec2.resources[0].autoscaling_groups[0].name
  lb_target_group_arn    = aws_lb_target_group.eks_nodes.arn
}