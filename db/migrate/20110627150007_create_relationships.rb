class CreateRelationships < ActiveRecord::Migration
  def self.up
    create_table :relationships do |t|
      t.string :rel_tag
	  
      t.timestamps
    end
  end

  def self.down
    drop_table :relationships
  end
end
