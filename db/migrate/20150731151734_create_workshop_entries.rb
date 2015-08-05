class CreateWorkshopEntries < ActiveRecord::Migration
  def change
    create_table :workshop_entries do |t|
      t.string :day
      t.string :month
      t.string :description
      t.string :photo

      t.timestamps null: false
    end
  end
end
