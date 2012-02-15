class RemoveExperimentFields < ActiveRecord::Migration
  def self.up
      remove_column :experiments, :interface_desc
      remove_column :experiments, :env_dim
      remove_column :experiments, :env_scale
      remove_column :experiments, :env_density
      remove_column :experiments, :env_realism
      remove_column :experiments, :env_desc
  end

  def self.down
      add_column :experiments, :interface_desc, :text
      add_column :experiments, :env_dim, :integer
      add_column :experiments, :env_scale, :integer
      add_column :experiments, :env_density, :integer
      add_column :experiments, :env_realism, :integer
      add_column :experiments, :env_desc, :text
  end
end
