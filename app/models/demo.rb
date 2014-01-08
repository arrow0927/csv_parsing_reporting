# == Schema Information
#
# Table name: demos
#
#  id              :integer          not null, primary key
#  created_at      :datetime
#  updated_at      :datetime
#  program_slot_id :integer
#  metric_type     :string(255)
#  Ind.2+          :string(255)
#  A18+            :string(255)
#  A25-54          :string(255)
#  A18-49          :string(255)
#  A18-34          :string(255)
#  A55+            :string(255)
#  F25-54          :string(255)
#  F18-49          :string(255)
#  F18-34          :string(255)
#  M25-54          :string(255)
#  M18-49          :string(255)
#  M18-34          :string(255)
#  A12-34          :string(255)
#  T12-17          :string(255)
#  C2-11           :string(255)
#

class Demo < ActiveRecord::Base

	belongs_to :program_slot 
	

	
end
