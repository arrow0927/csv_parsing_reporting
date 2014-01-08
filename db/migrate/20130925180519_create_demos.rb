class CreateDemos < ActiveRecord::Migration
  def change
    create_table :demos do |t|

      t.timestamps
      t.integer		:program_slot_id
      t.string		:metric_type
      t.decimal		:ind2Plus,	:precision=>	3, :scale=> 2
      t.decimal		:A18Plus,	:precision=>	3, :scale=> 2
      t.decimal		:A25To54,	:precision=>	3, :scale=> 2
      t.decimal		:A18To49,	:precision=>	3, :scale=> 2
      t.decimal		:A18To34,	:precision=>	3, :scale=> 2
      t.decimal		:A55Plus,	:precision=>	3, :scale=> 2
      t.decimal		:F25To54,	:precision=>	3, :scale=> 2
      t.decimal		:F18To49,	:precision=>	3, :scale=> 2
      t.decimal		:F18To34,	:precision=>	3, :scale=> 2
      t.decimal		:M25To54,	:precision=>	3, :scale=> 2
      t.decimal		:M18To49,	:precision=>	3, :scale=> 2
      t.decimal		:M18To34,	:precision=>	3, :scale=> 2
      t.decimal		:A12To34,	:precision=>	3, :scale=> 2
      t.decimal		:T12To17,	:precision=>	3, :scale=> 2
      t.decimal		:C2To11,	:precision=>	3, :scale=> 2
      
      
      
      
    end
  end
end
