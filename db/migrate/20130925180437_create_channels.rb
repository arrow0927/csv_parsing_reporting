class CreateChannels < ActiveRecord::Migration
  def change
    create_table :channels do |t|

      t.timestamps
      t.string	:channel_name
      t.string	:classification,	:default=> 0
      t.string	:ownership,	:default=> 0
      
      
    end
  end
end
