class CreateCities < ActiveRecord::Migration
  def change
    create_table :cities, options: "DEFAULT CHARSET=utf8" do |t|
      t.string :name
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
