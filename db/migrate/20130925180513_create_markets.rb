class CreateMarkets < ActiveRecord::Migration
  def change
    create_table :markets do |t|

      t.timestamps
      t.string	:market_name
      
      
      
    end
  end
end
