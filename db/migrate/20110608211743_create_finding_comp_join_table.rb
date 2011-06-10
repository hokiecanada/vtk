class CreateFindingCompJoinTable < ActiveRecord::Migration
  def self.up
    create_table :findings_comps, :id => false do |t|
	  t.integer :finding_id
	  t.integer :comp_id
	end
  end

  def self.down
    drop_table :findings_comps
  end
end
