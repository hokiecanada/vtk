class CreateFindings < ActiveRecord::Migration
  def self.up
    create_table :findings do |t|
      t.text :finding
      t.integer :specificity
      t.text :issues
      t.integer :num_views
      t.string :status
      t.references :experiment

      t.timestamps
    end
  end

  def self.down
    drop_table :findings
  end
end
