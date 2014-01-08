# == Schema Information
#
# Table name: channels
#
#  id             :integer          not null, primary key
#  created_at     :datetime
#  updated_at     :datetime
#  channel_name   :string(255)
#  classification :string(255)      default("0")
#  ownership      :string(255)      default("0")
#

class Channel < ActiveRecord::Base
	
	has_many :program_slots
	#attr_accessor :channel_name, :classification, :ownership
	#validates	:channel_name, :uniqueness => true
	

end
