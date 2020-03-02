Spree::Admin::ProductsController.class_eval do
  before_action :localize_prices, only: [:update, :create]

  private

  def localize_prices
    params[:product][:distributor_price] = Spree::LocalizedNumber.parse(params[:product][:distributor_price]).to_s  unless params[:product][:distributor_price].nil?
    params[:product][:wholesale_price] = Spree::LocalizedNumber.parse(params[:product][:wholesale_price]).to_s unless params[:product][:wholesale_price].nil?
    params[:product][:dealer_price] = Spree::LocalizedNumber.parse(params[:product][:dealer_price]).to_s unless params[:product][:dealer_price].nil?
  end
end
