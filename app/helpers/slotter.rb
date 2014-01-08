require 'time'
RANGES = [
  ["00:00:00", "LateNight"], #0
  ["05:00:00", "Morning"],   #1
  ["09:00:00", "Daytime"],   #2
  ["17:00:00", "Evening"],   #3
  ["20:00:00", "Prime"],     #4
  ["23:00:00", "LateNight"]] #5
NUM_PERIODS = RANGES.size #6
LAST_PERIOD = NUM_PERIODS - 1 #5
#===================================================================================
class Slotter
  
  def initialize
    @ranges = []
    RANGES.each {|r| @ranges << Time.strptime(r.first,"%H:%M:%S")}
    #@ranges = [2013-09-15 00:00:00 -0400, 2013-09-15 05:00:00 -0400, 2013-09-15 09:00:00 -0400, 2013-09-15 17:00:00 -0400, 2013-09-15 20:00:00 -0400, 2013-09-15 23:00:00 -0400]
  end
#===================================================================================
  def list_of_periods(start_time, end_time)  
    start_period = get_period_num_for_start_time(Time.strptime(start_time, "%H:%M:%S"))
    end_period = get_period_num_for_end_time(Time.strptime(end_time, "%H:%M:%S"))
    puts "Start period = #{start_period}"
    puts "End period = #{end_period}"
    if start_time <= end_time
      text = (start_period..end_period).to_a      
    else #start_time > end_time
      text = (start_period..LAST_PERIOD).to_a + (0..end_period).to_a     
    end
    text.map {|p| p == 0 ? LAST_PERIOD : p}.uniq.sort.map {|p| RANGES[p].last}
  end
#===================================================================================  
  private
#===================================================================================
	#t = 2013-09-15 23:00:00 -0400
def get_period_num_for_start_time(t) 
  	NUM_PERIODS.times do |period_number|
  		#if time is < the next time slot return period_number
		if period_number == LAST_PERIOD or t < @ranges[period_number+1]
			puts "Found period number for time #{t.inspect} = #{period_number}"
			return period_number
		end
  	end
end
#===================================================================================
#t = 2013-09-15 23:00:00 -0400
def get_period_num_for_end_time(t) 
  	NUM_PERIODS.times do |period_number|
		if period_number == LAST_PERIOD or t <= @ranges[period_number+1]
			puts "Found period number for time #{t.inspect} = #{period_number}"
			return period_number
		end
  	end
end


end

