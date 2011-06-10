class CreateFindingTaskJoinTable < ActiveRecord::Migration
  def self.up
    create_table :findings_tasks, :id => false do |t|
	  t.integer :finding_id
	  t.integer :task_id
	end
  end

  def self.down
    drop_table :findings_tasks
  end
end
