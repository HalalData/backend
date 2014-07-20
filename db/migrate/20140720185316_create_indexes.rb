class CreateIndexes < ActiveRecord::Migration
  def change
    create_table :indices, options: "ENGINE=MyISAM DEFAULT CHARSET=utf8" do |t|
      t.string :name
      t.text :address
      t.string :postal_code
      t.float :latitude
      t.float :longitude
      t.string :city_name
      t.float :city_latitude
      t.float :city_longitude
      t.string :country_name
      t.string :category_name

      t.timestamps
    end

    add_index :indices, [:name, :address, :country_name, :city_name], name: 'search_venue', type: :fulltext
  end
end
