class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.references :person, foreign_key: true
      t.references :address_type, foreign_key: true
      t.string :address, limit: 50
      t.string :zip, limit: 20
      t.string :city, limit: 50

      t.timestamps
    end
  end
end
