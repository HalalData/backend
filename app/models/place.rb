class Place < ActiveRecord::Base
	belongs_to :category
	belongs_to :country
end
