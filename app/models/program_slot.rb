# == Schema Information
#
# Table name: program_slots
#
#  id                    :integer          not null, primary key
#  program_id            :integer
#  market_id             :integer
#  channel_id            :integer
#  infosys_start         :string(255)
#  infosys_end           :string(255)
#  infosys_airdate       :string(255)
#  infosys_day           :string(255)
#  calendar_start        :datetime
#  calendar_end          :datetime
#  calendar_airdate      :date
#  timeslot              :string(255)
#  created_at            :datetime
#  updated_at            :datetime
#  normalized_start_time :string(255)
#  normalized_date       :string(255)
#  normalized_end_time   :string(255)
#

class ProgramSlot < ActiveRecord::Base
	belongs_to :market
	belongs_to :program
	belongs_to :channel
	has_many :demos	


#validates :program_id, :market_id, :channel_id, :infosys_start, :infosys_end, :infosys_airdate, :infosys_day, :calendar_start, :calendar_end, :calendar_airdate, :timeslot, {:allow_nil => false}



end
