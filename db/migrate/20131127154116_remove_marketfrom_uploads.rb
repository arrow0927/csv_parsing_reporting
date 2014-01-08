class RemoveMarketfromUploads < ActiveRecord::Migration
  def change
	remove_column :uploads, :market, :string
  end
end
