resource "aws_elastic_beanstalk_environment" "example" {
  name        = "test_environment"
  application = "testing"
  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MinSize"
    value     = "1"
  }
  dynamic "setting" {
    for_each = data.consul_key_prefix.environment.var
    content {
    heredoc = <<-EOF
    This is a heredoc template.
    It references ${local.other.3}
    EOF
    simple = "${4 - 2}"
    cond = test3 > 2 ? 1: 0
    heredoc2 = <<EOF
      Another heredoc, that
      doesn't remove indentation
      ${local.other.3}
      %{if true ? false : true}"gotcha"\n%{else}4%{endif}
    EOF
    loop = "This has a for loop: %{for x in local.arr}x,%{endfor}"
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = setting.key
    value     = setting.value
    }
  }
}
