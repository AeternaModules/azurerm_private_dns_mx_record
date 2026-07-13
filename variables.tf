variable "private_dns_mx_records" {
  description = <<EOT
Map of private_dns_mx_records, attributes below
Required:
    - resource_group_name
    - ttl
    - zone_name
    - record (block):
        - exchange (required)
        - preference (required)
Optional:
    - name
    - tags
EOT

  type = map(object({
    resource_group_name = string
    ttl                 = number
    zone_name           = string
    name                = optional(string)
    tags                = optional(map(string))
    record = list(object({
      exchange   = string
      preference = number
    }))
  }))
  validation {
    condition = alltrue([
      for k, v in var.private_dns_mx_records : (
        length(v.record) >= 1
      )
    ])
    error_message = "Each record list must contain at least 1 items"
  }
  validation {
    condition = alltrue([
      for k, v in var.private_dns_mx_records : (
        length(v.resource_group_name) <= 90
      )
    ])
    error_message = "[from resourcegroups.ValidateName: invalid when len(value) > 90]"
  }
  validation {
    condition = alltrue([
      for k, v in var.private_dns_mx_records : (
        !endswith(v.resource_group_name, ".")
      )
    ])
    error_message = "[from resourcegroups.ValidateName: must not end with \".\"]"
  }
  validation {
    condition = alltrue([
      for k, v in var.private_dns_mx_records : (
        length(v.resource_group_name) != 0
      )
    ])
    error_message = "[from resourcegroups.ValidateName: invalid when len(value) == 0]"
  }
  validation {
    condition = alltrue([
      for k, v in var.private_dns_mx_records : (
        length(v.zone_name) > 0
      )
    ])
    error_message = "must not be empty"
  }
  validation {
    condition = alltrue([
      for k, v in var.private_dns_mx_records : (
        alltrue([for item in v.record : (item.preference >= 0 && item.preference <= 65535)])
      )
    ])
    error_message = "must be between 0 and 65535"
  }
  validation {
    condition = alltrue([
      for k, v in var.private_dns_mx_records : (
        alltrue([for item in v.record : (length(item.exchange) > 0)])
      )
    ])
    error_message = "must not be empty"
  }
  validation {
    condition = alltrue([
      for k, v in var.private_dns_mx_records : (
        v.tags == null || (length(v.tags) <= 50)
      )
    ])
    error_message = "[from tags.Validate: invalid when len(value) > 50]"
  }
  # Note: 6 additional provider-side validators are enforced at apply time but not mirrored as validation{} blocks here (bespoke or non-mechanically-translatable).
}

