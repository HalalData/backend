class Place < ActiveRecord::Base
	has_one :category
	has_one :country
end
