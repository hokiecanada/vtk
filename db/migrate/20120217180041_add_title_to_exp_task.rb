class AddTitleToExpTask < ActiveRecord::Migration
  def self.up
	add_column :exp_tasks, :title, :string
  end

  def self.down
	remove_column :exp_tasks, :title
  end
end
