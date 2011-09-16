class AddAuthorOrderToJoinTable < ActiveRecord::Migration
  def self.up
	add_column :authors_papers, :order, :integer
  end

  def self.down
	drop_column :authors_papers, :order
  end
end
