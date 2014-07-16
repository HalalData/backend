class AddSourceToSearches < ActiveRecord::Migration
  def change
    add_column :searches, :source, :string
  end
end
