class ChangeDataTypeForDemosColumns < ActiveRecord::Migration
  def change
		change_table :demos do |d|
			d.change	:ind2Plus, :string
			d.change 	:A18Plus, :string
			d.change 	:A25To54,:string
			d.change 	:A18To49,:string
			d.change 	:A18To34,:string
			d.change 	:A55Plus,:string
			d.change	:F25To54,:string
			d.change	:F18To49, :string
			d.change	:F18To34, :string
			d.change	:M25To54, :string
			d.change	:M18To49, :string
			d.change	:M18To34, :string
			d.change	:A12To34, :string
			d.change	:T12To17, :string
			d.change	:C2To11, :string
		end
  end
end
