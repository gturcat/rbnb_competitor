class CreateFlats < ActiveRecord::Migration[5.2]
  def change
    create_table :flats do |t|
      t.string :title
      t.string :city
      t.string :zip_code
      t.text :description
      t.string :country
      t.string :street
      t.integer :price
      t.string :street_number
      t.integer :capacity
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
