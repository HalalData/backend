class Place < ActiveRecord::Base
	belongs_to :category
	belongs_to :city
	belongs_to :country
end
