class RenameColsInDemos < ActiveRecord::Migration
  def change
	rename_column(:demos, :ind2Plus ,"Ind.2+")
	rename_column(:demos, :A18Plus ,"A18+")
	rename_column(:demos, :A25To54 ,"A25-54")
	rename_column(:demos, :A18To49 ,"A18-49")
	rename_column(:demos, :A18To34 ,"A18-34")
	rename_column(:demos, :A55Plus ,"A55+")
	rename_column(:demos, :F25To54 ,"F25-54")
	rename_column(:demos, :F18To49 ,"F18-49")
	rename_column(:demos, :F18To34 ,"F18-34")
	rename_column(:demos, :M25To54 ,"M25-54")
	rename_column(:demos, :M18To49 ,"M18-49")
	rename_column(:demos, :M18To34 ,"M18-34")
	rename_column(:demos, :A12To34 ,"A12-34")
	rename_column(:demos, :T12To17 ,"T12-17")
	rename_column(:demos, :C2To11 ,"C2-11")

  end
end


