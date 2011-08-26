class DropFindingRelJoinTable < ActiveRecord::Migration
  def self.up
	drop_table :findings_relationships
  end

  def self.down
    create_table :findings_relationships, :id => false do |t|
	  t.integer :finding_id
	  t.integer :relationship_id
	end
  end
end
