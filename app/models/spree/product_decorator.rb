Spree::Product.class_eval do
  delegate :on_sale?, :clearance?, to: :find_or_build_master

  %i(sale_price wholesale_price distributor_price dealer_price).each do |method_name|
    delegate :"display_#{method_name}", to: :find_or_build_master
    delegate method_name, :"#{method_name}=", to: :find_or_build_master
  end
end
