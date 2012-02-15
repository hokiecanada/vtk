class ChangeFindingStatusToInt < ActiveRecord::Migration
  def self.up
	rename_column :findings, :status, :status_string
	add_column :findings, :status, :int
	
	Finding.reset_column_information
	Finding.find_each { |f| f.update_attribute(:status, :status_string) }
	remove_column :findings, :status_string
  end

  def self.down
	change_column :findings, :status, :string
  end
end
