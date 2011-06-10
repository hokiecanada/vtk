class CreateExperiments < ActiveRecord::Migration
  def self.up
    create_table :experiments do |t|
      t.integer :exp_type
	  t.string :title
      t.text :task_desc
      t.text :interface_desc
      t.integer :env_dim
      t.integer :env_scale
      t.integer :env_density
      t.integer :env_realism
      t.text :env_desc
      t.integer :part_num
      t.integer :part_gender
      t.integer :part_age
      t.text :part_background
      t.text :part_other
      t.text :systems_tech
      t.text :systems_desc
      t.text :comps_desc
      t.text :variables_desc
      t.text :constants
      t.text :other
      t.integer :num_views
      t.integer :status
	  t.references :paper

      t.timestamps
    end
  end

  def self.down
    drop_table :experiments
  end
end
