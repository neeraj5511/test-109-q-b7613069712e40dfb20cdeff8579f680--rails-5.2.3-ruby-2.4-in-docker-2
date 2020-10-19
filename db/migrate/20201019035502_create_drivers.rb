class CreateDrivers < ActiveRecord::Migration[5.2]
  def change
    create_table :drivers do |t|
      t.string :name
      t.string :email
      t.integer :phone_number
      t.string :license_number
      t.string :car_number

      t.timestamps
    end
  end
end
