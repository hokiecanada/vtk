class AddResearchQuestionsToExperiment < ActiveRecord::Migration
  def self.up
	add_column :experiments, :goals, :text
  end

  def self.down
	remove_column :experiments, :goals
  end
end
