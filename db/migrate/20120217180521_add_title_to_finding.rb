class AddTitleToFinding < ActiveRecord::Migration
  def self.up
	add_column :findings, :title, :string
  end

  def self.down
	remove_column :findings, :title
  end
end
