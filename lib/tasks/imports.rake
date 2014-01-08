require "csv"
#All files use CSV Parser to parse and populate models

#========Rake task to import channels===========================
#####   Disabled this rake task as Channels will be added through db:seed 
#####
# desc "Import Channels into DB \nUsage: rake \"import_channels[/Users/ash.mulekar/Desktop/overnights/overnightsProjects/overnight_rails_projects/0925/Channellist.csv]\""
# 
# task	:import_channels, [:file_path] => [:environment] do |t, args|
#   	puts "rake recived arguments:"
# 	puts "file_path = #{args.file_path}"
# 	options = Hash[:file_path =>args.file_path , :mode =>:channel, :market =>nil]
# 	@cp = CsvParser.new(options)
# end

#==========Rake task to import national data=====================
desc "Import National Data into DB\n Usage: rake \"import_national[/Users/ash.mulekar/Desktop/overnights/overnightsProjects/overnight_rails_projects/0925/National.csv]\""

task	:import_national, [:file_path] => [:environment] do |t, args|
  	puts "rake recived arguments:"
	puts "file_path = #{args.file_path}"
	options = Hash[:file_path =>args.file_path , :mode =>:national, :market=>:national]
	@cp = CsvParser.new(options)

end

#==========Rake task to import regional data=====================
desc "Import Regional Data into DB\n Usage: rake \"import_regional[/Users/ash.mulekar/Desktop/overnights/overnightsProjects/overnight_rails_projects/0925/Calgary.csv, Calgary]\""

task	:import_regional, [:file_path, :market] => [:environment] do |t, args|

	
  	puts "rake recived arguments:"
	puts "file_path = #{args.file_path}"
	options = Hash[:file_path =>args.file_path , :mode =>:regional, :market=> args.market]
	@cp = CsvParser.new(options)

end
