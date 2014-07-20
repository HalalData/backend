class Index < ActiveRecord::Base

	# Doing the full text search in sql
	#
	# @param query is a string to be searched
	# @return array
	def self.full_text_search(query, page)
		sql = "SELECT id, name, address, postal_code, city_name, city_latitude, city_longitude, country_name, source, "
  	sql << "MATCH(name, address, city_name, country_name) AGAINST('#{query}') AS score "
  	sql << "FROM indices WHERE MATCH(name, address, city_name, country_name) AGAINST('#{query}') ORDER BY score DESC;"
	
  	Kaminari.paginate_array(self.find_by_sql(sql)).page(page)
	end

end
