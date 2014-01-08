class AddStatus < ActiveRecord::Migration
  def change
	add_column :uploads, :status, :integer, :default => 0, :null=>false
  end
end
