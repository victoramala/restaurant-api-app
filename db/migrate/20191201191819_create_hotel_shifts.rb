class CreateHotelShifts < ActiveRecord::Migration[5.2]
  def change
    create_table :hotel_shifts do |t|
      t.string :name
      t.time :start_time
      t.time :end_time
      t.references :hotel, foreign_key: true

      t.timestamps
    end
  end
end
