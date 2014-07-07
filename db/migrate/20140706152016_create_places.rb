class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.string :name, null: false
      t.text :address
      t.string :postal_code
      t.string :phone
      t.string :fax
      t.string :email
      t.string :website
      t.float :latitude, default: 0
      t.float :longitude, default: 0
      t.belongs_to :category
      t.belongs_to :country

      t.timestamps
    end
  end
end
