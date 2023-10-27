## The AWS Translate API needs to be enabled in the AWS console
## The IAM User is entered into the Weblate UI, there is no automated way to inject this.

resource "aws_iam_user" "automatic_suggestion_weblate" {
  name = "AutomaticSuggestionWeblate"
}

resource "aws_iam_access_key" "weblate" { 
  user = aws_iam_user.automatic_suggestion_weblate.name
  status = "Active"
}

data "aws_iam_policy" "translate_full_access" { 
  name = "TranslateFullAccess"
}

resource "aws_iam_user_policy_attachment" "translate_full_access" {
  user       = aws_iam_user.automatic_suggestion_weblate.name
  policy_arn = data.aws_iam_policy.translate_full_access.arn
}


