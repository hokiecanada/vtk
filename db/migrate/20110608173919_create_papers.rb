class CreatePapers < ActiveRecord::Migration
  def self.up
    create_table :papers do |t|
      t.string :title
	  t.string :journal
	  t.date :year
	  t.integer :volume
	  t.integer :number
	  t.integer :first_page
	  t.integer :last_page
	  t.string :doi
      t.string :paper_url
	  t.integer :num_views
	  t.integer :status
	  t.references :user

      t.timestamps
    end
  end

  def self.down
    drop_table :papers
  end
end
