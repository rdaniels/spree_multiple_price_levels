Spree::OrdersController.class_eval do
  before_action :set_price_level, before: :populate

  def set_price_level
    params[:options] = {} if params[:options].nil?
    if spree_current_user
      params[:options][:price_level] = 'wholesale' if spree_current_user.has_spree_role?(:wholesale)
      params[:options][:price_level] = 'distributor' if spree_current_user.has_spree_role?(:distributor)
      params[:options][:price_level] = 'dealer' if spree_current_user.has_spree_role?(:dealer)
    end
  end
end
