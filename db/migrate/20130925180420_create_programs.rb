class CreatePrograms < ActiveRecord::Migration
  def change
    create_table :programs do |t|

      t.timestamps
      t.string		:program_name
      t.string		:episode_name
      
      
    end
  end
end
