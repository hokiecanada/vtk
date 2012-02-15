class CreateExpTasks < ActiveRecord::Migration
  def self.up
    create_table :exp_tasks do |t|
      t.string :task_desc
	  t.integer :task_id
      t.references :experiment

      t.timestamps
    end
  end

  def self.down
    drop_table :exp_tasks
  end
end
