class CreatePeople < ActiveRecord::Migration[5.2]
  def change
    create_table :people do |t|
      t.string :first_name, limit: 50
      t.string :last_name, limit: 50
      t.date :birthday

      t.timestamps
    end
  end
end
