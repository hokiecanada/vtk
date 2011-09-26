class ChangeFindingStatusToInt < ActiveRecord::Migration
  def self.up
	change_column :findings, :status, :int
  end

  def self.down
	change_column :findings, :status, :string
  end
end
