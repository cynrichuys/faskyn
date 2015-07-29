class CreateShopEntries < ActiveRecord::Migration
  def change
    create_table :shop_entries do |t|
      t.string :price
      t.string :description
      t.string :photo

      t.timestamps null: false
    end
  end
end
