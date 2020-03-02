Spree::Variant.class_eval do
  include Spree::ActsAsTaggable

  scope :on_sale, -> { where.not(sale_price: [nil, 0.0]) }
  scope :clearance, -> { tagged_with('clearance') }

  def on_sale?
    sale_price.present? && sale_price.nonzero?
  end

  def clearance?
    tag_list.include? 'Clearance'
  end

  def display_distributor_price
    Spree::Money.new(amount: distributor_price.to_f)
  end

  def display_wholesale_price
    Spree::Money.new(amount: wholesale_price.to_f)
  end

  def display_sale_price
    Spree::Money.new(amount: sale_price.to_f)
  end

  def display_dealer_price
    Spree::Money.new(amount: dealer_price.to_f)
  end

  def price_including_vat_for(price_options)
    tmp_price = price_options[:price] || price
    options = price_options.merge(tax_category: tax_category)
    Spree::Price.new(variant_id: id, amount: price, currency: 'USD').gross_amount(tmp_price, options)
  end

  def price_in_price_level(price_level)
    temp_price = price

    temp_price = sale_price if sale_price.present? && sale_price.nonzero? && price_level.blank?

    temp_price = dealer_price if price_level == 'dealer' && dealer_price.present? && dealer_price.nonzero?
    temp_price = wholesale_price if price_level == 'wholesale' && wholesale_price.present? && wholesale_price.nonzero?
    temp_price = distributor_price if price_level == 'distributor' && distributor_price.present? && distributor_price.nonzero?

    # 30% OFF
    # temp_price *= 0.7 if clearance?

    Spree::Price.new(variant_id: id, amount: temp_price, currency: 'USD')
  end
end
