class Experiment < ActiveRecord::Base
	has_and_belongs_to_many :tasks,
							:join_table => :experiments_tasks
	has_and_belongs_to_many :comps,
							:join_table => :experiments_comps
	has_and_belongs_to_many :metrics,
							:join_table => :experiments_metrics
	has_and_belongs_to_many :systems,
							:join_table => :experiments_systems
	belongs_to :paper
	has_many :findings
	accepts_nested_attributes_for	:tasks, :findings,
									:reject_if => :all_blank,
									:allow_destroy => true;
end
