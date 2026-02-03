resource "aws_sns_topic" "alerts" {
  name = "${local.project}-alerts"

  tags = merge(local.tags, {
    "Category" = "alerts"
  })
}

resource "aws_sns_topic_subscription" "email" {
  for_each = { for addr in var.alert_emails : addr => addr }

  topic_arn = aws_sns_topic.alerts.arn
  protocol  = "email"
  endpoint  = each.value
}

resource "aws_sfn_state_machine" "defcon" {
  name     = "${local.project}-defcon"
  role_arn = var.scoring_state_machine_role_arn

  definition = jsonencode({
    "Comment" : "Hybrid War Agent DEFCON Bewertung",
    "StartAt" : "CalculateScore",
    "States" : {
      "CalculateScore" : {
        "Type" : "Pass",
        "Result" : {
          "message" : "Placeholder für Scoring-Logik"
        },
        "ResultPath" : "$.scoring",
        "Next" : "Notify"
      },
      "Notify" : {
        "Type" : "Task",
        "Resource" : "arn:aws:states:::sns:publish",
        "Parameters" : {
          "Message.$" : "States.Format('DEFCON-Level aktualisiert: {}', $.scoring.message)",
          "TopicArn" : aws_sns_topic.alerts.arn
        },
        "End" : true
      }
    }
  })

  tags = merge(local.tags, {
    "Name" = "${local.project}-defcon"
  })
}
