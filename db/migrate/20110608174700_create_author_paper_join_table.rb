class CreateAuthorPaperJoinTable < ActiveRecord::Migration
  def self.up
    create_table :authors_papers, :id => false do |t|
	  t.integer :author_id
	  t.integer :paper_id
	end
  end

  def self.down
    drop_table :authors_papers
  end
end
