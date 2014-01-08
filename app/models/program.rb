# == Schema Information
#
# Table name: programs
#
#  id           :integer          not null, primary key
#  created_at   :datetime
#  updated_at   :datetime
#  program_name :string(255)
#  episode_name :string(255)
#

class Program < ActiveRecord::Base
		
	has_many :program_slots
	#validates :program_name, {:allow_nil => false}

end
