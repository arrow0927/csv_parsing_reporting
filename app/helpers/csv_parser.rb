#!/usr/bin/env ruby
#encoding: utf-8
require "csv"
require "Rrow"
require "slotter"
require "date"
require "date_range"

class CsvParser
		attr_accessor :file_path, :mode, :csv, :rows, :markets, :upload

#options = {:file_path => " " , :mode => :XXX}
def initialize(options)
	puts "\nInitializing CSVParser with :\n#{options.inspect}"
	@mode = options[:mode]
	@market = options[:market]
	@file_path = options[:file_path]
	@upload = Upload.find(options[:upload_id])
  	@csv = CSV.read("#{@file_path}")
	populate_markets()
	parse_csv()
	
	
end#initialize

#=============================================
private 
#=============================================
def parse_csv()
		begin #Exception
		@upload.update!(:status=>3)

		case @mode
			when :channel
				puts "parsing channels" 
				parse_channels_and_enter_in_DB()
			when :national
				puts "parsing national data, mode = #{@mode}"
				parse_data()
				#@rows is an array of Rrow objects
				#puts "Rows = \n #{@rows.inspect}"
				populate_dB()
				@rows = nil
			when :regional
				puts "parsing regional, mode = #{@mode}, market = #{@market}"
				parse_data()
				populate_dB()
				#@rows = nil
			else
				puts "ERROR invalid mode in csv parser" 
		end
		rescue Exception => e
				puts "Exception occured in #{__FILE__}/#{__method__}"
				puts "Exception Message=\n #{e.message}"
				puts e.backtrace.inspect
				@upload.update!(:status=> 0)
		end #Exception
		@upload.update!(:status => 2)
end#end parse_csv


#=================================================================================
#parses the csv, inserts/updates channel in the database 
def parse_channels_and_enter_in_DB()
	channel_hash = Hash.new()
	puts "Parsing channels"
	@csv.each_with_index do |row, i|
  		if [0].include?(i)
        	puts "Skipping over row #{i}"
        	next
    	end
    	if(row.nil?)
        	puts "row[#{i}] was nil"
    	else
			channelName = nil
        	classif = nil
        	owner = nil
        	#puts "#{row.inspect}"
			channelName = row[0].force_encoding('UTF-8')
        	classif = row[1].force_encoding('UTF-8')
        	owner = row[2].force_encoding('UTF-8') 
        
			if (channelName.nil?)
          		puts "Channel name for row #{i} was nil"
          		#add entry to Log file or errors database
          		next #skip this row of the csv file and go to next row
        	else
				ch = Channel.where(:channel_name =>"#{channelName}").first_or_create
				ch.update_attributes(:ownership =>"#{owner}", :classification =>"#{classif}")
        		puts "#{ch.inspect} created\n\n"
			end
      	end#end if/else
  	end #end CSV.each
end#end parse channels

#=================================================================================
def parse_data()
	
	metrics = nil
	demos = nil
	headers = nil
	headers_row_number = nil
	firstDemoCol = nil
	header_values = nil
	rows_array = Array.new
	num_dataRows = 0 #This variable will populate column: uploads.total_rows in the view
	puts "Parsing data in #{__FILE__}/#{__method__}"
	puts "variable @file_path = #{@file_path}"
	puts "Market = #{@market} "
	puts "@file_path.class = #{@file_path.class}"

	@csv.each_with_index do |row, i|
    	puts "{{      row[#{i}]       }}"	
    	row.delete_at(0) 
      if(row.include?"Stats >>") 
        firstDemoCol = row.index("Stats >>") + 1 #we need the column index where demos start from in a row
        headers_row_number = i + 1 
        #puts "Row #{i} contains metrics"
		#metrics are the titles of the demo values
        metrics = row.slice!(row.index("Stats >>") + 1, row.length()).compact 
        #puts "metrics = #{metrics.inspect}"
        #puts "number of metrics = #{metrics.length()}"
     elsif (i == headers_row_number)
       #puts "First column of demos is #{firstDemoCol}"
       #puts "Headers = #{row.slice(0, firstDemoCol)}"
       headers = row.slice(0, firstDemoCol)
       #puts "Demos = #{row.slice(firstDemoCol, row.length())}"
       demos = row.slice(firstDemoCol, row.length())
		#demos are repeated for each metric so get rid of the repeats
       demos = demos.slice!(0, demos.length() / metrics.length() ) 
       #puts "truncated demos = #{demos.inspect}"
     elsif (i == 0)
       puts "skipping row #{i}..."
       next
     else
       if(row[0] == "Summary")
         puts "row number #{i} has Summary data.......skipping"
         next
       else
         num_dataRows += 1
         header_values = row.slice(0, firstDemoCol.to_i)
         demo_values = row.slice(firstDemoCol.to_i, row.length())
         #puts ""
         #puts "header_values = #{header_values}"
         #puts "demo_values = #{demo_values}"
         aRow = Rrow.new(headers, metrics, demos)
         aRow.addValues(header_values,demo_values)
         aRow.add_market(@market)
		 #puts "#{aRow.inspect}"
         rows_array = rows_array << aRow
       end
     end
  end #csv each
    puts "Finished reading #{num_dataRows} data entries"
	@upload.update!(:total_rows => num_dataRows)# Added 12/18 by Ash
	@rows = rows_array
	puts "Created a rows array with #{@rows.length()} rows"

end#parse_data()


=begin
Rrow.row_hash = {"Program"=>"BIG FUN MOVIES", "Channel"=>"YTV+", "Date"=>"10/6/2013", "Weekday"=>"Sunday", "Start time"=>"02:00:00", "End time"=>"02:15:00", "Duration"=>"00:15:00", "Episode Name"=>"Wizard of Oz", 

"demos"=>{
"Ind.2+"=>{"AMA(000)"=>"90.4", "Shr% [Total TV Eng]"=>"4.9", "#Stations"=>"3"}, 
"A18+"=>{"AMA(000)"=>"71.4", "Shr% [Total TV Eng]"=>"4.3", "#Stations"=>"3"}, 
"A25-54"=>{"AMA(000)"=>"59", "Shr% [Total TV Eng]"=>"6.1", "#Stations"=>"3"}, 
"A18-49"=>{"AMA(000)"=>"63.7", "Shr% [Total TV Eng]"=>"7.3", "#Stations"=>"3"}, 
"A18-34"=>{"AMA(000)"=>"52.4", "Shr% [Total TV Eng]"=>"11.3", "#Stations"=>"3"}, 
"A55+"=>{"AMA(000)"=>"2", "Shr% [Total TV Eng]"=>"0.3", "#Stations"=>"3"}, 
"F25-54"=>{"AMA(000)"=>"31.7", "Shr% [Total TV Eng]"=>"6.8", "#Stations"=>"3"}, 
"F18-49"=>{"AMA(000)"=>"28.4", "Shr% [Total TV Eng]"=>"6.8", "#Stations"=>"3"}, 
"F18-34"=>{"AMA(000)"=>"17.3", "Shr% [Total TV Eng]"=>"8", "#Stations"=>"3"}, 
"M25-54"=>{"AMA(000)"=>"27.4", "Shr% [Total TV Eng]"=>"5.5", "#Stations"=>"3"}, 
"M18-49"=>{"AMA(000)"=>"35.3", "Shr% [Total TV Eng]"=>"7.7", "#Stations"=>"3"}, 
"M18-34"=>{"AMA(000)"=>"35.1", "Shr% [Total TV Eng]"=>"14.3", "#Stations"=>"3"}, 
"A12-34"=>{"AMA(000)"=>"61.5", "Shr% [Total TV Eng]"=>"11.4", "#Stations"=>"3"}, 
"T12-17"=>{"AMA(000)"=>"9.1", "Shr% [Total TV Eng]"=>"12.1", "#Stations"=>"3"}, 
"C2-11"=>{"AMA(000)"=>"9.9", "Shr% [Total TV Eng]"=>"9.6", "#Stations"=>"3"}}}
=end
#=================================================================================
#populates db with the data from the csv file or updates the db if the file has already been read.
def populate_dB()
	puts "populating DB for market #{@market}"
	populate_markets()
	market_id = Market.find_by market_name: @market
	puts "market_id = #{market_id}, for market_name_from_db = #{Market.find(market_id)}"
	@rows.each_with_index do |r, i|
		puts "===================reading from @rows[#{i}] and inserting into db============================"
		rh = r.row_hash
		#puts "Rrow.row_hash = #{rh.inspect}"
		#Transformations to data
		cal_start_arr = normalized_date_time(rh["Date"],rh["Start time"])#[date, time]
		cal_end_arr = (normalized_date_time(rh["Date"],rh["End time"]))#[date, time]
		cal_start_combined = cal_start_arr.split(',').join(' ') 
		cal_end_combined = cal_end_arr.split(',').join(' ')
		air_date_combined = airDate_from_combined_date_time(cal_start_combined)	

        #Computer Time Slot based on slotter.rb
        slt = Slotter.new
		puts "Sending following parameters to Slotter to get time-slot. Start time = #{cal_start_arr[1]}, End time = #{ cal_end_arr[1]}"
        timeSlotArray = slt.list_of_periods(cal_start_arr[1], cal_end_arr[1]) 
        timeSlot = timeSlotArray.join(",")

		pr = Program.where(	
						:program_name =>"#{rh["Program"]}", 
						:episode_name =>"#{rh["Episode Name"]}"
						).first_or_create
		puts "Created/Updated program id = #{pr.id}"

		ch = Channel.where(
						:channel_name =>"#{rh["Channel"]}").first_or_create
		puts "Created/Updated channel id = #{ch.id}"
		pslot = ProgramSlot.where(
						:program_id => pr.id, 
						:market_id => market_id, 
						:channel_id => ch.id).first_or_create
		puts "Created/Updated programSlot id = #{pslot.id}"
		pslot.update_attributes(
						:infosys_start => "#{rh["Start time"]}",
						:infosys_end=> "#{rh["End time"]}", 
						:infosys_airdate => "#{rh["Date"]}", 
						:infosys_day =>"#{rh["Weekday"]}", 
						:calendar_start => cal_start_combined,
						:calendar_end=> cal_end_combined, 
						:calendar_airdate=> air_date_combined,
						:normalized_date=> cal_start_arr[0],
						:normalized_start_time=> cal_start_arr[1],
						:normalized_end_time=> cal_end_arr[1],
						:timeslot=>timeSlot )
		#======================================================
		#Testing functionality to extract dates from CSV files
		dr = DateRange.where(:date_range => pslot.calendar_airdate).first_or_create	
		@upload.date_ranges << dr unless @upload.date_ranges.include?(dr)

		#======================================================
		demos_hash = rh["demos"]
		metrics_arr = r.metrics_array
		all_demos_keys = demos_hash.keys
		puts "all_demos_keys = #{all_demos_keys}"
		puts "Available Metrics for market #{@market} and this row = #{metrics_arr.inspect}"

		metrics_arr.each do |metric_type|
			all_demos_keys.each do |demo_key|
				dm = Demo.where(:program_slot_id => pslot.id, :metric_type =>metric_type ).first_or_create
				dm.update_attributes(demo_key => demos_hash[demo_key][metric_type])
			end #all_demos_keys.each do |demo_key|				
		end #metrics_arr.each do |metric_type
		@upload.update!(:rows_completed => i)#Added by Ash on 12-18
	end#@rows.each_with_index do |r, i|
	 

end#populate_db
#=================================================================================
def populate_markets()
	@markets =[:National, :Toronto, :Calgary, :Edmonton, :Vancouver]
	@markets.each do |m|
		Market.where(:market_name =>"#{m}" ).first_or_create
	end
end#populate markets

#=================================================================================
# IN("10/6/2013", "02:00:00") method changes the infosys airdate to the next date if the start time is >= 24 hr
#OUT ["2013-10-17", "11:00:00"]
def normalized_date_time(infosysAirDate, timeString) 
      
      	puts "infosysAirDate = #{infosysAirDate}"
		puts "time = #{timeString}"	  
		#IN -> "8/15/2013" #OUT -> "2013-08-15"
		formatted_infosysAirDate_string = format_Infosys_Date(infosysAirDate) 
		time_array = timeString.split(":")
		hour = time_array[0].to_i
		modified_date = nil
		if(hour >= 24) #hour is more than 24 clock
        	normalized_hr = (24 - hour).abs
      		time_array[0] = normalized_hr.to_s
			normalized_date_obj = Date.strptime(formatted_infosysAirDate_string, "%Y-%m-%d")
			modified_date = normalized_date_obj.next.to_s
		else
			modified_date = formatted_infosysAirDate_string
		end
		modified_time = time_array.join(':')
		puts "modified_time = #{modified_time}"
		puts "modified_date = #{modified_date}"
		normalized_arr = ["#{modified_date}", "#{modified_time}"]
		puts "normalized_arr = #{normalized_arr} "
		normalized_arr
end#normalized_date_time

#=================================================================================
def format_Infosys_Date(infosysAirDate) #IN -> "8/15/2013" #OUT -> "2013-08-15"
      @fdate = nil
      dateArr = infosysAirDate.split("/")
      @fdate = "#{dateArr[2]}-#{dateArr[0].rjust(2, '0')}-#{dateArr[1].rjust(2, '0')}"  
    end#format_Infosys_Date
    
#=================================================================================    
#2013-8-15 20:00:00 = calendarStartTime

 def airDate_from_combined_date_time(calendarStartTime)
      arr = calendarStartTime.split(" ")
      puts "airDate_from_combined_date_time - Array of calendarStartTime = #{arr.inspect}"
      @calAirDate = nil
      @calAirDate = "#{arr[0]}"
    end#airDate_from_combined_date_time
end#class CsvParser