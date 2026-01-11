resource "azurerm_private_dns_mx_record" "private_dns_mx_records" {
  for_each = var.private_dns_mx_records

  resource_group_name = each.value.resource_group_name
  ttl                 = each.value.ttl
  zone_name           = each.value.zone_name
  name                = each.value.name
  tags                = each.value.tags

  record {
    exchange   = each.value.record.exchange
    preference = each.value.record.preference
  }
}

