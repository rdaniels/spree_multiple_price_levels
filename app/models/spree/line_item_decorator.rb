Spree::LineItem.class_eval do
  def update_price
    self.price = variant.price_including_vat_for(price: variant.price_in_price_level(order.user.try(:price_level)).price, tax_zone: tax_zone)
  end

  def update_price_from_modifier(currency, opts)
    price_level = opts.delete(:price_level)
    if currency
      self.currency = currency
      self.price = variant.price_in_price_level(price_level).amount + variant.price_modifier_amount_in(currency, opts)
    else
      self.price = variant.price_in_price_level(price_level).amount + variant.price_modifier_amount(opts)
    end
  end
end
