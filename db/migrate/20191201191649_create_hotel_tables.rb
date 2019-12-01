class CreateHotelTables < ActiveRecord::Migration[5.2]
  def change
    create_table :hotel_tables do |t|
      t.string :name
      t.integer :min_guest_count
      t.integer :max_guest_count
      t.references :hotel, foreign_key: true

      t.timestamps
    end
  end
end
