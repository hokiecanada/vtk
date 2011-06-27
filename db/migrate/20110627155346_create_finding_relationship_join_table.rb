class CreateFindingRelationshipJoinTable < ActiveRecord::Migration
  def self.up
    create_table :findings_relationships, :id => false do |t|
	  t.integer :finding_id
	  t.integer :relationship_id
	end
  end

  def self.down
      drop_table :findings_relationships
  end
end
