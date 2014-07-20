class AddPhoneFaxEmailWebsiteToIndexes < ActiveRecord::Migration
  def change
    add_column :indices, :phone, :string
    add_column :indices, :fax, :string
    add_column :indices, :email, :string
    add_column :indices, :website, :string
  end
end
