class AddRelIdToFindings < ActiveRecord::Migration
  def self.up
	add_column :findings, :rel_id, :integer
  end

  def self.down
	drop_column :findings, :rel_id
  end
end
