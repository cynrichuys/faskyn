class AddSoldToShopEntries < ActiveRecord::Migration
  def change
    add_column :shop_entries, :sold, :boolean
  end
end
