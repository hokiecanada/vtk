class CreateSystems < ActiveRecord::Migration
  def self.up
    create_table :systems do |t|
      t.string :system_tag
	  
      t.timestamps
    end
  end

  def self.down
    drop_table :systems
  end
end
