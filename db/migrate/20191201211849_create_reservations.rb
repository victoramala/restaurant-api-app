class CreateReservations < ActiveRecord::Migration[5.2]
  def change
    create_table :reservations do |t|
      t.datetime :reservation_time
      t.integer :guest_count
      t.references :guest, foreign_key: true
      t.references :hotel_table, foreign_key: true

      t.timestamps
    end
  end
end
