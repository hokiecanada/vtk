class CreateExperimentCompJoinTable < ActiveRecord::Migration
  def self.up
    create_table :experiments_comps, :id => false do |t|
	  t.integer :experiment_id
	  t.integer :comp_id
	end
  end

  def self.down
    drop_table :experiments_comps
  end
end
