resource "google_compute_security_policy_rule" "compute_security_policy_rules" {
  for_each = var.compute_security_policy_rules

  action          = each.value.action
  priority        = each.value.priority
  security_policy = each.value.security_policy
  deletion_policy = each.value.deletion_policy
  description     = each.value.description
  preview         = each.value.preview
  project         = each.value.project

  dynamic "header_action" {
    for_each = each.value.header_action != null ? [each.value.header_action] : []
    content {
      dynamic "request_headers_to_adds" {
        for_each = header_action.value.request_headers_to_adds != null ? header_action.value.request_headers_to_adds : []
        content {
          header_name  = request_headers_to_adds.value.header_name
          header_value = request_headers_to_adds.value.header_value
        }
      }
    }
  }

  dynamic "match" {
    for_each = each.value.match != null ? [each.value.match] : []
    content {
      dynamic "config" {
        for_each = match.value.config != null ? [match.value.config] : []
        content {
          src_ip_ranges = config.value.src_ip_ranges
        }
      }
      dynamic "expr" {
        for_each = match.value.expr != null ? [match.value.expr] : []
        content {
          expression = expr.value.expression
        }
      }
      dynamic "expr_options" {
        for_each = match.value.expr_options != null ? [match.value.expr_options] : []
        content {
          recaptcha_options {
            action_token_site_keys  = expr_options.value.recaptcha_options.action_token_site_keys
            session_token_site_keys = expr_options.value.recaptcha_options.session_token_site_keys
          }
        }
      }
      versioned_expr = match.value.versioned_expr
    }
  }

  dynamic "preconfigured_waf_config" {
    for_each = each.value.preconfigured_waf_config != null ? [each.value.preconfigured_waf_config] : []
    content {
      dynamic "exclusion" {
        for_each = preconfigured_waf_config.value.exclusion != null ? preconfigured_waf_config.value.exclusion : []
        content {
          dynamic "request_cookie" {
            for_each = exclusion.value.request_cookie != null ? exclusion.value.request_cookie : []
            content {
              operator = request_cookie.value.operator
              value    = request_cookie.value.value
            }
          }
          dynamic "request_header" {
            for_each = exclusion.value.request_header != null ? exclusion.value.request_header : []
            content {
              operator = request_header.value.operator
              value    = request_header.value.value
            }
          }
          dynamic "request_query_param" {
            for_each = exclusion.value.request_query_param != null ? exclusion.value.request_query_param : []
            content {
              operator = request_query_param.value.operator
              value    = request_query_param.value.value
            }
          }
          dynamic "request_uri" {
            for_each = exclusion.value.request_uri != null ? exclusion.value.request_uri : []
            content {
              operator = request_uri.value.operator
              value    = request_uri.value.value
            }
          }
          target_rule_ids = exclusion.value.target_rule_ids
          target_rule_set = exclusion.value.target_rule_set
        }
      }
    }
  }

  dynamic "rate_limit_options" {
    for_each = each.value.rate_limit_options != null ? [each.value.rate_limit_options] : []
    content {
      ban_duration_sec = rate_limit_options.value.ban_duration_sec
      dynamic "ban_threshold" {
        for_each = rate_limit_options.value.ban_threshold != null ? [rate_limit_options.value.ban_threshold] : []
        content {
          count        = ban_threshold.value.count
          interval_sec = ban_threshold.value.interval_sec
        }
      }
      conform_action = rate_limit_options.value.conform_action
      enforce_on_key = rate_limit_options.value.enforce_on_key
      dynamic "enforce_on_key_configs" {
        for_each = rate_limit_options.value.enforce_on_key_configs != null ? rate_limit_options.value.enforce_on_key_configs : []
        content {
          enforce_on_key_name = enforce_on_key_configs.value.enforce_on_key_name
          enforce_on_key_type = enforce_on_key_configs.value.enforce_on_key_type
        }
      }
      enforce_on_key_name = rate_limit_options.value.enforce_on_key_name
      exceed_action       = rate_limit_options.value.exceed_action
      dynamic "exceed_redirect_options" {
        for_each = rate_limit_options.value.exceed_redirect_options != null ? [rate_limit_options.value.exceed_redirect_options] : []
        content {
          target = exceed_redirect_options.value.target
          type   = exceed_redirect_options.value.type
        }
      }
      dynamic "rate_limit_threshold" {
        for_each = rate_limit_options.value.rate_limit_threshold != null ? [rate_limit_options.value.rate_limit_threshold] : []
        content {
          count        = rate_limit_threshold.value.count
          interval_sec = rate_limit_threshold.value.interval_sec
        }
      }
    }
  }

  dynamic "redirect_options" {
    for_each = each.value.redirect_options != null ? [each.value.redirect_options] : []
    content {
      target = redirect_options.value.target
      type   = redirect_options.value.type
    }
  }

  dynamic "timeouts" {
    for_each = each.value.timeouts != null ? [each.value.timeouts] : []
    content {
      create = timeouts.value.create
      delete = timeouts.value.delete
      update = timeouts.value.update
    }
  }
}

