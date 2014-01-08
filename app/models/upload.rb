# == Schema Information
#
# Table name: uploads
#
#  id                      :integer          not null, primary key
#  created_at              :datetime
#  updated_at              :datetime
#  sourcedata_file_name    :string(255)
#  sourcedata_content_type :string(255)
#  sourcedata_file_size    :integer
#  sourcedata_updated_at   :datetime
#  task_id                 :integer
#  status                  :integer          default(0), not null
#  f_path                  :string(255)
#  job                     :string(255)
#  daterange               :string(255)
#  email                   :string(255)
#  total_rows              :integer
#  rows_completed          :integer
#

#

# upload status can have values : 
# -1 = File deleted
#  0 = error
#  1 = File saved on server - show button
#  2 = entered in DB - hide button
#  3 = entering in DB - hide button
#  4 = add button clicked - hide button

# task_id: 
# 1=>mode=channel, market=nil, 
# 2=>mode=national, market=National, 
# 3=>mode=regional, market=Toronto, 
# 4=>mode=regional, market=Calgary, 
# 5=>mode=regional, market=Edmonton, 
# 6=>mode=regional, market=Vancouver, 

class Upload < ActiveRecord::Base
	belongs_to :task
	#has_and_belongs_to_many :date_ranges, :uniq => true
	#After deprecation warning in Rails 4 changed the above to the following:
	has_and_belongs_to_many :date_ranges, -> { uniq }
	validates_presence_of :sourcedata	
	validate :fileName
	

	has_attached_file(
					:sourcedata,
					:path => "#{Rails.root}/imports/#{Date.today.to_s}/#{Time.now.strftime("%H_%M" )}/:basename.:extension",
					)
	
	def fileName
		if(sourcedata_file_name.blank?)
			errors.add(:sourcedata_file_name, "cannot be blank")
		else
			s = sourcedata_file_name.split(".")[0]
			if s != task.name
				errors.add(:sourcedata_file_name, "-- ERROR -- file name doesn't match the market" )
			end
		end
	end

	def add_data_to_DB()
		puts "entered upload model/add_data_to_DB method"
		mode = nil
	
		market = nil
		case self.task_id
			when 1
				mode = :channel
				market = nil
			when 2
				mode = :national
				market = :national
			when 3
				mode = :regional
				market = :toronto
			when 4
				mode = :regional
				market = :calgary
			when 5
				mode = :regional
				market = :edmonton
			when 6
				mode = :regional
				market = :vancouver
			else
				puts"Error!! Received invalid task.id to parse"
			end
	options = Hash[:file_path => self.f_path , :mode =>mode, :market=>market, :upload_id =>self.id]
	puts "Calling CSV parser with \noptions= #{options.inspect}"
	#self.update!(:status => 3)
	@cp = CsvParser.new(options)
	end
	handle_asynchronously :add_data_to_DB
	
	def percentage_complete
		return 0 if total_rows.nil? || total_rows == 0
		((rows_completed + 1).to_f / total_rows.to_f ) * 100
	end


end
