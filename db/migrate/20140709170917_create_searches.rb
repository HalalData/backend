class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches, options: "ENGINE=MyISAM" do |t|
      t.string :name
      t.text :address
      t.string :postal_code
      t.float :latitude
      t.float :longitude
      t.string :country_name
      t.string :category_name

      t.timestamps
    end

    add_index :searches, [:name, :address, :country_name, :category_name], name: 'search_venue', type: :fulltext
  end
end
