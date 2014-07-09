namespace :importdata do
  desc "Insert data from Singapore MUIS dataset"
  task :singapore, [:filepath, :sheet] => :environment do |task, args|
		workbook = RubyXL::Parser.parse(args.filepath)
		worksheet = workbook[args.sheet]

		sheet_data = worksheet.extract_data

		# iterate the array
		sheet_data.each do |row|
			
			# create the object
			place = Place.new()

			row.each_with_index do |item, index|
				if index == 0
					place.name = item
				elsif index == 1
					place.address = item
				else
					place.postal_code = item
				end
			end
			place.category_id = 1
			place.country_id = 1
			place.save
		end
  end

  desc "TODO"
  task :thailand, [:filepath] => :environment do |task, args|
  	puts "Thailand"
  end

end
