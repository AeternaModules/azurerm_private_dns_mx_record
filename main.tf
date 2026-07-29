resource "azurerm_private_dns_mx_record" "private_dns_mx_records" {
  for_each = var.private_dns_mx_records

  private_dns_zone_id = each.value.private_dns_zone_id
  ttl                 = each.value.ttl
  name                = each.value.name
  tags                = each.value.tags

  dynamic "record" {
    for_each = each.value.record
    content {
      exchange   = record.value.exchange
      preference = record.value.preference
    }
  }
}

