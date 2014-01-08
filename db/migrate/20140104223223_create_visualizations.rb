class CreateVisualizations < ActiveRecord::Migration
  def change
    create_table :visualizations do |t|

      t.timestamps
    end
  end
end
