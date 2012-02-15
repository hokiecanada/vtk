class CreateExpTaskTaskJoinTable < ActiveRecord::Migration
  def self.up
    create_table :exp_tasks_tasks, :id => false do |t|
	  t.integer :exp_task_id
	  t.integer :task_id
	end
  end

  def self.down
    drop_table :exp_tasks_tasks
  end
end
