namespace :indexing do
  desc "Copy data from Place table to Search table"
  task search: :environment do
  	places = Place.all

  	places.each do |row|
  		search = Search.create(
  			name: row.name, 
  			address: row.address, 
  			postal_code: row.postal_code, 
  			latitude: row.latitude, 
  			longitude: row.longitude,
  			country_name: row.country.name,
  			category_name: row.category.name
  			)
  	end
  end

end
