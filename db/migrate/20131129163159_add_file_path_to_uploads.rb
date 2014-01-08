class AddFilePathToUploads < ActiveRecord::Migration
  def change
    add_column :uploads, :f_path, :string
  end
end
