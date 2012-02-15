class AddExpTaskIdToFindings < ActiveRecord::Migration
  def self.up
	add_column :findings, :exp_task_id, :integer
  end

  def self.down
	remove_column :findings, :exp_task_id
  end
end
