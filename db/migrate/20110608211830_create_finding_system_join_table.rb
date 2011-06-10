class CreateFindingSystemJoinTable < ActiveRecord::Migration
  def self.up
    create_table :findings_systems, :id => false do |t|
	  t.integer :finding_id
	  t.integer :system_id
	end
  end

  def self.down
    drop_table :findings_systems
  end
end
