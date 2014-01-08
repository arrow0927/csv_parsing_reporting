# == Schema Information
#
# Table name: markets
#
#  id          :integer          not null, primary key
#  created_at  :datetime
#  updated_at  :datetime
#  market_name :string(255)
#

class Market < ActiveRecord::Base
	
		has_many :program_slots
		#Sometimes you'll want a property to be one of a given set of options. 
		#Try inclusion, which takes an array (or any other enumerable object).
		
		validates :market_name, inclusion: ['National', 'Toronto', 'Calgary', 'Edmonton', 'Vancouver']

end
