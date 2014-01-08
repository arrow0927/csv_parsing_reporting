class AddTaskIdToUploads < ActiveRecord::Migration
  def change
	add_column :uploads, :task_id, :integer
	#remove_column :uploads, :service_id, :integer
  end
end
