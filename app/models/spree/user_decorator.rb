Spree::User.class_eval do
  def retail?
    return false if has_spree_role?(:wholesale)
    return false if has_spree_role?(:distributor)
    return false if has_spree_role?(:dealer)

    return true
  end

  def price_level
    price_level = ''

    price_level = 'wholesale' if has_spree_role?(:wholesale)
    price_level = 'distributor' if has_spree_role?(:distributor)
    price_level = 'dealer' if has_spree_role?(:dealer)

    return price_level
  end
end
