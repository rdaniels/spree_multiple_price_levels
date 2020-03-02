Deface::Override.new(
  virtual_path: 'spree/admin/products/_form',
  name: 'add_prices_to_product_form',
  insert_before: '[data-hook="admin_product_form_cost_price"]',
  partial: '/overrides/spree/admin/products/form/prices'
)
