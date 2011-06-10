class CreateExperimentTaskJoinTable < ActiveRecord::Migration
  def self.up
    create_table :experiments_tasks, :id => false do |t|
	  t.integer :experiment_id
	  t.integer :task_id
	end
  end

  def self.down
    drop_table :experiments_tasks
  end
end
