class CreateTableAuthorPapers < ActiveRecord::Migration
  def self.up
    create_table :author_papers do |t|
      t.integer :author_id
	  t.integer :paper_id
	  t.integer :order
	end
  end

  def self.down
	drop_table :author_papers
  end
end
