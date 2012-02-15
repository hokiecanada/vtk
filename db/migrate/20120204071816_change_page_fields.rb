class ChangePageFields < ActiveRecord::Migration
  def self.up
	change_column :papers, :first_page, :string
	remove_column :papers, :last_page
  end

  def self.down
	change_column :papers, :first_page, :int
	add_column :papers, :last_page, :int
  end
end
