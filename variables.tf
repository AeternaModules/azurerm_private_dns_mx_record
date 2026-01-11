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
    name                = optional(string, "@")
    tags                = optional(map(string))
    record = object({
      exchange   = string
      preference = number
    })
  }))
}

