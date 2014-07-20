class AddSourceToIndices < ActiveRecord::Migration
  def change
    add_column :indices, :source, :string
  end
end
