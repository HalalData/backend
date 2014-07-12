namespace :indexing do
  desc "Copy data from Place table to Search table"
  task search: :environment do
  	places = Place.all

  	places.each do |row|
      update_search = Search.find_by(id: row.id)

      if update_search
        update_search.id = row.id
        update_search.name = row.name 
        update_search.address = row.address 
        update_search.postal_code = row.postal_code 
        update_search.phone = row.phone
        update_search.fax = row.fax
        update_search.email = row.email
        update_search.website = row.website
        update_search.longitude = row.longitude
        update_search.country_name = row.country.name
        update_search.category_name = row.category.name
        update_search.save
      else
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

end
