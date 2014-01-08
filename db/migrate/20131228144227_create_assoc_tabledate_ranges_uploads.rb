class CreateAssocTabledateRangesUploads < ActiveRecord::Migration
  def change
    create_table :date_ranges_uploads do |t|
		t.belongs_to :date_range
		t.belongs_to :upload
    end
  end
end
