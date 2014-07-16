class Search < ActiveRecord::Base
	
	# Doing the full text search in sql
	#
	# @param query is a string to be searched
	# @return array
	def self.full_text_search(query, page)
		sql = "SELECT id, name, address, postal_code, category_name, country_name, source, "
  	sql << "MATCH(name, address, category_name, country_name) AGAINST('#{query}') AS score "
  	sql << "FROM searches WHERE MATCH(name, address, category_name, country_name) AGAINST('#{query}') ORDER BY score DESC;"
	
  	Kaminari.paginate_array(self.find_by_sql(sql)).page(page)
	end
end
