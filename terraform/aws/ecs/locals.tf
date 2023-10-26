locals {
  container_environment = [
    {
      "name"  = "WEBLATE_DEBUG",
      "value" = "0"
    },
    {
      "name"  = "WEBLATE_LOGLEVEL",
      "value" = "INFO"
    },
    {
      "name"  = "WEBLATE_SITE_DOMAIN",
      "value" = var.domain
    },
    {
      "name"  = "WEBLATE_SITE_TITLE",
      "value" = "Weblate"
    },
    {
      "name"  = "WEBLATE_ADMIN_NAME",
      "value" = "Weblate Admin"
    },
    {
      "name"  = "WEBLATE_SERVER_EMAIL",
      "value" = "platform@cds-snc.ca"
    },
    {
      "name"  = "WEBLATE_DEFAULT_FROM_EMAIL",
      "value" = "platform@cds-snc.ca"
    },
    {
      "name"  = "WEBLATE_ALLOWED_HOSTS",
      "value" = var.domain
    },
    {
      "name"  = "WEBLATE_REGISTRATION_OPEN",
      "value" = "1"
    },
    {
      "name"  = "WEBLATE_REGISTRATION_ALLOW_BACKENDS",
      "value" = "google-oauth2"
    },
    {
      "name"  = "WEBLATE_SOCIAL_AUTH_GOOGLE_OAUTH2_WHITELISTED_DOMAINS",
      "value" = "cds-snc.ca"
    },
    {
      "name"  = "WEBLATE_ENABLE_HTTPS",
      "value" = "1"
    },
    {
      "name"  = "POSTGRES_DATABASE",
      "value" = "weblate"
    },
    {
      "name"  = "POSTGRES_PORT",
      "value" = "5432"
    },
    {
      "name"  = "REDIS_DB",
      "value" = "0"
    },
    {
      "name"  = "REDIS_PORT",
      "value" = "6379"
    },
    {
      "name"  = "REDIS_TLS",
      "value" = "1"
    },
    {
      "name"  = "SESSION_COOKIE_SECURE",
      "value" = "True"
    },
    {
      "name"  = "SECURE_SSL_REDIRECT",
      "value" = "True"
    },
    {
      "name"  = "CLIENT_MAX_BODY_SIZE",
      "value" = "200M"
    },
  ]

  container_secrets = [
    {
      "name"      = "POSTGRES_HOST",
      "valueFrom" = var.weblate_database_host_secret_arn
    },
    {
      "name"      = "POSTGRES_PASSWORD",
      "valueFrom" = var.weblate_database_password_secret_arn
    },
    {
      "name"      = "POSTGRES_USER",
      "valueFrom" = var.weblate_database_username_secret_arn
    },
    {
      "name"      = "REDIS_HOST",
      "valueFrom" = var.weblate_redis_url_secret_arn
    },
    {
      "name"      = "REDIS_PASSWORD",
      "valueFrom" = var.weblate_redis_auth_token_secret_arn
    },
    {
      "name"      = "WEBLATE_SOCIAL_AUTH_GOOGLE_OAUTH2_KEY",
      "valueFrom" = aws_ssm_parameter.weblate_google_client_id.arn,
    },
    {
      "name"      = "WEBLATE_SOCIAL_AUTH_GOOGLE_OAUTH2_SECRET",
      "valueFrom" = aws_ssm_parameter.weblate_google_client_secret.arn,
    },
    {
      "name"      = "WEBLATE_ADMIN_EMAIL",
      "valueFrom" = aws_ssm_parameter.weblate_admin_email.arn,
    },
    {
      "name"      = "WEBLATE_ADMIN_PASSWORD",
      "valueFrom" = aws_ssm_parameter.weblate_admin_password.arn
    },
  ]
}
