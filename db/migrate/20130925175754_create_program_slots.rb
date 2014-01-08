class CreateProgramSlots < ActiveRecord::Migration
  def change
    create_table :program_slots do |t|
    
    	t.integer	:program_id
    	t.integer	:market_id
    	t.integer	:channel_id
    	t.string	:infosys_start
    	t.string	:infosys_end
    	t.string	:infosys_airdate
    	t.string	:infosys_day
    	t.datetime	:calendar_start
    	t.datetime	:calendar_end
    	t.date		:calendar_airdate
    	t.string	:timeslot

      t.timestamps
    end
  end
end
