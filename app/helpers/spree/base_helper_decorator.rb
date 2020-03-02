Spree::FrontendHelper.class_eval do
  def display_price_for_price_level(variant)
    price_level = ''

    if spree_current_user
      price_level = 'wholesale' if spree_current_user.has_spree_role?(:wholesale)
      price_level = 'distributor' if spree_current_user.has_spree_role?(:distributor)
      price_level = 'dealer' if spree_current_user.has_spree_role?(:dealer)
    end

    variant.price_in_price_level(price_level).display_price.to_html
  end

  def display_price_without_clearance_and_without_sale(variant)
    price_level = ''

    if spree_current_user
      price_level = 'wholesale' if spree_current_user.has_spree_role?(:wholesale)
      price_level = 'distributor' if spree_current_user.has_spree_role?(:distributor)
      price_level = 'dealer' if spree_current_user.has_spree_role?(:dealer)
    end

    temp_price = variant.price

    temp_price = variant.dealer_price if price_level == 'dealer' && dealer_price.present? && dealer_price.nonzero?
    temp_price = variant.wholesale_price if price_level == 'wholesale' && wholesale_price.present? && wholesale_price.nonzero?
    temp_price = variant.distributor_price if price_level == 'distributor' && distributor_price.present? && distributor_price.nonzero?

    Spree::Money.new(amount: temp_price)
  end

  def item_on_sale?(product_or_variant)
    return false if spree_current_user && not(spree_current_user.retail?)

    product_or_variant.on_sale?
  end
end
