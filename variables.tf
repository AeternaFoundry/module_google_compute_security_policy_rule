variable "compute_security_policy_rules" {
  description = <<EOT
Map of compute_security_policy_rules, attributes below
Required:
    - action
    - priority
    - security_policy
Optional:
    - deletion_policy
    - description
    - preview
    - project
    - header_action (block):
        - request_headers_to_adds (optional, block):
            - header_name (optional)
            - header_value (optional)
    - match (block):
        - config (optional, block):
            - src_ip_ranges (optional)
        - expr (optional, block):
            - expression (required)
        - expr_options (optional, block):
            - recaptcha_options (required, block):
                - action_token_site_keys (optional)
                - session_token_site_keys (optional)
        - versioned_expr (optional)
    - preconfigured_waf_config (block):
        - exclusion (optional, block):
            - request_cookie (optional, block):
                - operator (required)
                - value (optional)
            - request_header (optional, block):
                - operator (required)
                - value (optional)
            - request_query_param (optional, block):
                - operator (required)
                - value (optional)
            - request_uri (optional, block):
                - operator (required)
                - value (optional)
            - target_rule_ids (optional)
            - target_rule_set (required)
    - rate_limit_options (block):
        - ban_duration_sec (optional)
        - ban_threshold (optional, block):
            - count (optional)
            - interval_sec (optional)
        - conform_action (optional)
        - enforce_on_key (optional)
        - enforce_on_key_configs (optional, block):
            - enforce_on_key_name (optional)
            - enforce_on_key_type (optional)
        - enforce_on_key_name (optional)
        - exceed_action (optional)
        - exceed_redirect_options (optional, block):
            - target (optional)
            - type (optional)
        - rate_limit_threshold (optional, block):
            - count (optional)
            - interval_sec (optional)
    - redirect_options (block):
        - target (optional)
        - type (optional)
    - timeouts (block):
        - create (optional)
        - delete (optional)
        - update (optional)
EOT

  type = map(object({
    action          = string
    priority        = number
    security_policy = string
    deletion_policy = optional(string)
    description     = optional(string)
    preview         = optional(bool)
    project         = optional(string)
    header_action = optional(object({
      request_headers_to_adds = optional(list(object({
        header_name  = optional(string)
        header_value = optional(string)
      })))
    }))
    match = optional(object({
      config = optional(object({
        src_ip_ranges = optional(list(string))
      }))
      expr = optional(object({
        expression = string
      }))
      expr_options = optional(object({
        recaptcha_options = object({
          action_token_site_keys  = optional(list(string))
          session_token_site_keys = optional(list(string))
        })
      }))
      versioned_expr = optional(string)
    }))
    preconfigured_waf_config = optional(object({
      exclusion = optional(list(object({
        request_cookie = optional(list(object({
          operator = string
          value    = optional(string)
        })))
        request_header = optional(list(object({
          operator = string
          value    = optional(string)
        })))
        request_query_param = optional(list(object({
          operator = string
          value    = optional(string)
        })))
        request_uri = optional(list(object({
          operator = string
          value    = optional(string)
        })))
        target_rule_ids = optional(list(string))
        target_rule_set = string
      })))
    }))
    rate_limit_options = optional(object({
      ban_duration_sec = optional(number)
      ban_threshold = optional(object({
        count        = optional(number)
        interval_sec = optional(number)
      }))
      conform_action = optional(string)
      enforce_on_key = optional(string)
      enforce_on_key_configs = optional(list(object({
        enforce_on_key_name = optional(string)
        enforce_on_key_type = optional(string)
      })))
      enforce_on_key_name = optional(string)
      exceed_action       = optional(string)
      exceed_redirect_options = optional(object({
        target = optional(string)
        type   = optional(string)
      }))
      rate_limit_threshold = optional(object({
        count        = optional(number)
        interval_sec = optional(number)
      }))
    }))
    redirect_options = optional(object({
      target = optional(string)
      type   = optional(string)
    }))
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      update = optional(string)
    }))
  }))
  validation {
    condition = alltrue([
      for k, v in var.compute_security_policy_rules : (
        v.preconfigured_waf_config == null || (v.preconfigured_waf_config.exclusion == null || alltrue([for item in v.preconfigured_waf_config.exclusion : (item.request_cookie == null || alltrue([for item in item.request_cookie : (contains(["EQUALS", "STARTS_WITH", "ENDS_WITH", "CONTAINS", "EQUALS_ANY"], item.operator))]))]))
      )
    ])
    error_message = "must be one of: \"EQUALS\", \"STARTS_WITH\", \"ENDS_WITH\", \"CONTAINS\", \"EQUALS_ANY\""
  }
  validation {
    condition = alltrue([
      for k, v in var.compute_security_policy_rules : (
        v.preconfigured_waf_config == null || (v.preconfigured_waf_config.exclusion == null || alltrue([for item in v.preconfigured_waf_config.exclusion : (item.request_header == null || alltrue([for item in item.request_header : (contains(["EQUALS", "STARTS_WITH", "ENDS_WITH", "CONTAINS", "EQUALS_ANY"], item.operator))]))]))
      )
    ])
    error_message = "must be one of: \"EQUALS\", \"STARTS_WITH\", \"ENDS_WITH\", \"CONTAINS\", \"EQUALS_ANY\""
  }
  validation {
    condition = alltrue([
      for k, v in var.compute_security_policy_rules : (
        v.preconfigured_waf_config == null || (v.preconfigured_waf_config.exclusion == null || alltrue([for item in v.preconfigured_waf_config.exclusion : (item.request_query_param == null || alltrue([for item in item.request_query_param : (contains(["EQUALS", "STARTS_WITH", "ENDS_WITH", "CONTAINS", "EQUALS_ANY"], item.operator))]))]))
      )
    ])
    error_message = "must be one of: \"EQUALS\", \"STARTS_WITH\", \"ENDS_WITH\", \"CONTAINS\", \"EQUALS_ANY\""
  }
  validation {
    condition = alltrue([
      for k, v in var.compute_security_policy_rules : (
        v.preconfigured_waf_config == null || (v.preconfigured_waf_config.exclusion == null || alltrue([for item in v.preconfigured_waf_config.exclusion : (item.request_uri == null || alltrue([for item in item.request_uri : (contains(["EQUALS", "STARTS_WITH", "ENDS_WITH", "CONTAINS", "EQUALS_ANY"], item.operator))]))]))
      )
    ])
    error_message = "must be one of: \"EQUALS\", \"STARTS_WITH\", \"ENDS_WITH\", \"CONTAINS\", \"EQUALS_ANY\""
  }
  # Note: 3 additional provider-side validators are enforced at apply time but not mirrored as validation{} blocks here (bespoke or non-mechanically-translatable).
}

