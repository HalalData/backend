class AddPhoneFaxEmailWebsiteToSearch < ActiveRecord::Migration
  def change
    add_column :searches, :phone, :string
    add_column :searches, :fax, :string
    add_column :searches, :email, :string
    add_column :searches, :website, :string
  end
end
