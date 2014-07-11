namespace :indexing do
  desc "Copy data from Place table to Search table"
  task search: :environment do
  	places = Place.all

  	places.each do |row|
      search = Search.new
      search.id = row.id
      search.name = row.name 
  		search.address = row.address 
  		search.postal_code = row.postal_code 
      search.phone = row.phone
      search.fax = row.fax
      search.email = row.email
      search.website = row.website
  		search.longitude = row.longitude
  		search.country_name = row.country.name
  		search.category_name = row.category.name
  		search.save
  	end
  end

end
