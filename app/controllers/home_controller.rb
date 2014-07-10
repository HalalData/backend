class HomeController < ApplicationController
  def index
  end

  # Query the data
  def show
  	query = "SELECT id, name, address, postal_code, category_name, country_name, "
  	query << "MATCH(name, address, category_name, country_name) AGAINST('#{params[:query]}') AS score "
  	query << "FROM searches WHERE MATCH(name, address, category_name, country_name) AGAINST('#{params[:query]}');"

  	places = Search.find_by_sql(query)

  	@response = places
  end
end
