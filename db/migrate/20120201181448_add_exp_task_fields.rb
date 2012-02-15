class AddExpTaskFields < ActiveRecord::Migration
  def self.up
      add_column :exp_tasks, :interface_desc, :text
      add_column :exp_tasks, :env_dim, :integer
      add_column :exp_tasks, :env_scale, :integer
      add_column :exp_tasks, :env_density, :integer
      add_column :exp_tasks, :env_realism, :integer
      add_column :exp_tasks, :env_desc, :text
	  add_column :exp_tasks, :status, :integer
  end

  def self.down
      drop_column :exp_tasks, :interface_desc
      drop_column :exp_tasks, :env_dim
      drop_column :exp_tasks, :env_scale
      drop_column :exp_tasks, :env_density
      drop_column :exp_tasks, :env_realism
      drop_column :exp_tasks, :env_desc
	  drop_column :exp_tasks, :status
  end
end
