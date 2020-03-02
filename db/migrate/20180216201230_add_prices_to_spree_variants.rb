class AddPricesToSpreeVariants < ActiveRecord::Migration[5.1]
  def change
    add_column :spree_variants, :sale_price, :decimal, precision: 8, scale: 2
    add_column :spree_variants, :wholesale_price, :decimal, precision: 8, scale: 2
    add_column :spree_variants, :vip_price, :decimal, precision: 8, scale: 2
  end
end
