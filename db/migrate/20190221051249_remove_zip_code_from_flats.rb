class RemoveZipCodeFromFlats < ActiveRecord::Migration[5.2]
  def change
    remove_column :flats, :zip_code, :string
    remove_column :flats, :city, :string
    remove_column :flats, :country, :string
    remove_column :flats, :street, :string
    remove_column :flats, :street_number, :string
  end
end
