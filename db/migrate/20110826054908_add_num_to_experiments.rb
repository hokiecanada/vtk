class AddNumToExperiments < ActiveRecord::Migration
  def self.up
	add_column :experiments, :num, :integer
  end

  def self.down
	drop_column :experiments, :num
  end
end
