class DataMgr

def initialize
	puts "Data Mgr initialized"
end

def clear_program_slots
	puts "Clearing Database Table: program_slots"
	ProgramSlot.destroy_all
	ActiveRecord::Base.connection.execute("TRUNCATE TABLE `program_slots`")
end


def clear_programs
	puts "Clearing Database Table: programs"
	Program.destroy_all
	ActiveRecord::Base.connection.execute("TRUNCATE TABLE PROGRAMS")
end


def clear_markets
    puts "Clearing Database Table: markets"	
	Market.destroy_all
	ActiveRecord::Base.connection.execute("TRUNCATE TABLE MARKETS")
end


def clear_demos
	puts "Clearing Database TABLE: DEMOS"
	Demo.destroy_all
	ActiveRecord::Base.connection.execute("TRUNCATE TABLE DEMOS")
end

def clear_uploads
	puts "Clearing Database TABLE: UPLOADS"
	Upload.destroy_all
	ActiveRecord::Base.connection.execute("TRUNCATE TABLE UPLOADS")
end

def clear_tasks
	puts "Clearing Database TABLE: TASKS"
	Task.destroy_all
	ActiveRecord::Base.connection.execute("TRUNCATE TABLE TASKS")
end


def reset_db
	clear_program_slots
	clear_demos
	clear_programs
	clear_markets
	clear_uploads
	clear_tasks
end


end#DataMgr