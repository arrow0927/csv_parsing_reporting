class AddMarketNameToUploads < ActiveRecord::Migration
  def change
    add_column :uploads, :market, :string
  end
end
