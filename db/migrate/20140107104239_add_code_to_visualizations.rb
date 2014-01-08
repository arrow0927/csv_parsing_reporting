class AddCodeToVisualizations < ActiveRecord::Migration
  def change
    add_column :visualizations, :code, :string
  end
end
