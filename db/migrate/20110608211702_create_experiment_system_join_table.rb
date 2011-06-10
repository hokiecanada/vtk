class CreateExperimentSystemJoinTable < ActiveRecord::Migration
  def self.up
    create_table :experiments_systems, :id => false do |t|
	  t.integer :experiment_id
	  t.integer :system_id
	end
  end

  def self.down
    drop_table :experiments_systems
  end
end
