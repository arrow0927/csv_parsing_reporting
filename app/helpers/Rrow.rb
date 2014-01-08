#encoding: utf-8
class Rrow
    attr_accessor :headers_array, :metrics_array, :demos_types_array, :header_vals, :demo_vals, :row_hash, :market

#Rrow.headers = ["Program", "Channel", "Date", "Weekday", "Start time", "End time", "Duration", "Episode Name"]

#Rrow.headers_values = ["VICTORIOUS", "YTV+", "10/6/2013", "Sunday", "02:30:00", "03:00:00", "00:30:00", " "]

#Rrow.metrics = ["AMA(000)", "Shr% [Total TV Eng]", "#Stations"]

#Rrow demo_types = ["Ind.2+", "A18+", "A25-54", "A18-49", "A18-34", "A55+", "F25-54", "F18-49", "F18-34", "M25-54", "M18-49", "M18-34", "A12-34", "T12-17", "C2-11"]

#Rrow demo_values = ["69.5", "57", "46.7", "57", "52.4", "0", "19.6", "19.6", "17.3", "27.1", "37.4", "35.1", "52.4", "0", "12.5", "5.4", "4.9", "7.4", "9.2", "16.5", "0", "6.1", "6.3", "10.9", "8.7", "12.3", "22.1", "14.1", "0", "21.2", "3", "3", "3", "3", "3", "3", "3", "3", "3", "3", "3", "3", "3", "3", "3"]

=begin
Rrow.row_hash = {"Program"=>"SPONGEBOB SQUAREPANT", "Channel"=>"YTV+", "Date"=>"10/6/2013", "Weekday"=>"Sunday", "Start time"=>"02:15:00", "End time"=>"02:30:00", "Duration"=>"00:15:00", "Episode Name"=>"Special", "demos"=>{"Ind.2+"=>{"AMA(000)"=>"79.4", "Shr% [Total TV Eng]"=>"5.1", "#Stations"=>"3"}, "A18+"=>{"AMA(000)"=>"61.2", "Shr% [Total TV Eng]"=>"4.3", "#Stations"=>"3"}, "A25-54"=>{"AMA(000)"=>"50.5", "Shr% [Total TV Eng]"=>"6.2", "#Stations"=>"3"}, "A18-49"=>{"AMA(000)"=>"58", "Shr% [Total TV Eng]"=>"7.8", "#Stations"=>"3"}, "A18-34"=>{"AMA(000)"=>"52.4", "Shr% [Total TV Eng]"=>"13.7", "#Stations"=>"3"}, "A55+"=>{"AMA(000)"=>"0.4", "Shr% [Total TV Eng]"=>"0.1", "#Stations"=>"3"}, "F25-54"=>{"AMA(000)"=>"23.8", "Shr% [Total TV Eng]"=>"5.7", "#Stations"=>"3"}, "F18-49"=>{"AMA(000)"=>"21", "Shr% [Total TV Eng]"=>"5.6", "#Stations"=>"3"}, "F18-34"=>{"AMA(000)"=>"17.3", "Shr% [Total TV Eng]"=>"9.5", "#Stations"=>"3"}, "M25-54"=>{"AMA(000)"=>"26.6", "Shr% [Total TV Eng]"=>"6.7", "#Stations"=>"3"}, "M18-49"=>{"AMA(000)"=>"36.9", "Shr% [Total TV Eng]"=>"9.9", "#Stations"=>"3"}, "M18-34"=>{"AMA(000)"=>"35.1", "Shr% [Total TV Eng]"=>"17.4", "#Stations"=>"3"}, "A12-34"=>{"AMA(000)"=>"59.4", "Shr% [Total TV Eng]"=>"13.3", "#Stations"=>"3"}, "T12-17"=>{"AMA(000)"=>"7", "Shr% [Total TV Eng]"=>"11.2", "#Stations"=>"3"}, "C2-11"=>{"AMA(000)"=>"11.2", "Shr% [Total TV Eng]"=>"14.7", "#Stations"=>"3"}}}
=end

 
  def initialize(headers, metrics, demos)
      @headers_array = headers
      @metrics_array = metrics
      @demos_types_array = demos
      @market = nil
      #puts "Created a Rrow object with: \n#{@headers_array.inspect} \n #{metrics_array.inspect} \n#{@demos_types_array}"
      
  end
    

  def addValues(header_vals, demo_vals )
      @header_vals = header_vals
      @demo_vals = demo_vals
      create_hash
      
  end
  
    
  def print_row_hash
    puts ""
    puts " printing row hash = #{@row_hash}"
    
  end

    def row_hash
        @row_hash
    end
    

	def metrics_array
		@metrics_array
	end
    def add_market(m)
      @market = m
    end
    
    def market
      @market
    end
    
    def create_hash
        if(@headers_array.length() != @header_vals.length)
            raise "headers length mismatch"
        elsif(@demo_vals.length() / @demos_types_array.length() != @metrics_array.length() )
            raise "Wrong number of demo values. There might be more or less values than demos"
        else
            puts "creating hash "
        
        row_hash = Hash[ @headers_array.map {|key| [key, nil] } ]
        
        row_hash.each do |header , value |
            header_index = @headers_array.index(header)
            row_hash[header] = @header_vals[header_index]
            #puts "row_hash[#{header}] = #{@header_vals[header_index]} "
            
        end
        
        
        metrics_hash = Hash[ @metrics_array.map {|key| [key, nil] }]
        demos_hash = Hash[@demos_types_array.map {|key| [key, metrics_hash.dup] } ]
        
        demos_hash.each do |demo , metric_hash |
            metric_hash.each do |metric , value |
                demo_index = @demos_types_array.index(demo)
                metric_index = @metrics_array.index(metric)
                #puts "demo = #{demo} demo_index = #{demo_index}"
                #puts "metric = #{metric} metric_index = #{metric_index}"
                offset = @demos_types_array.length() 
                value_index = metric_index * offset + demo_index 
                value = @demo_vals[value_index]
                #puts "value =  #{value} value_index =  #{value_index}"
                
                metric_hash[metric] = @demo_vals[value_index]
                #puts "metric_hash[#{metric}] = #{metric_hash[metric]} "
            end
            
            #puts "#{demo.inspect} => #{metric_hash.inspect} "
        end
        
        
        
        row_hash = row_hash.merge!({"demos" => demos_hash } )
        @row_hash = row_hash
        #puts "\nJust created \n@row_hash = #{@row_hash.inspect} "
        end
        
        
    end
    
    
    private :create_hash
  

end
