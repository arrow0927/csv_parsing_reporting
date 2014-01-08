# == Schema Information
#
# Table name: date_ranges
#
#  id          :integer          not null, primary key
#  date_range  :string(255)
#  description :text
#  created_at  :datetime
#  updated_at  :datetime
#

class DateRange < ActiveRecord::Base
	#has_and_belongs_to_many :uploads, :uniq => true
	#After deprecation warning in Rails 4 changed the above to the following:
	has_and_belongs_to_many :uploads, -> { uniq }
end
