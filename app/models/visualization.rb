# == Schema Information
#
# Table name: visualizations
#
#  id          :integer          not null, primary key
#  created_at  :datetime
#  updated_at  :datetime
#  name        :string(255)
#  description :string(255)
#  code        :string(255)
#

class Visualization < ActiveRecord::Base
end
