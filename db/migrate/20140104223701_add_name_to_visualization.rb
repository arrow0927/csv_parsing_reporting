class AddNameToVisualization < ActiveRecord::Migration
  def change
    add_column :visualizations, :name, :string
	add_column :visualizations, :description, :string
  end
end
