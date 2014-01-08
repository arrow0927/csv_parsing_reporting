class AddJobToUpload < ActiveRecord::Migration
  def change
    add_column :uploads, :job, :string
  end
end
