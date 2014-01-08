class AddDaterangeToUploads < ActiveRecord::Migration
  def change
    add_column :uploads, :daterange, :string
	add_column :uploads, :email, :string
  end
end
