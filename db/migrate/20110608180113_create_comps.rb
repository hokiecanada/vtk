class CreateComps < ActiveRecord::Migration
  def self.up
    create_table :comps do |t|
      t.string :comp_tag
	  
      t.timestamps
    end
  end

  def self.down
    drop_table :comps
  end
end
