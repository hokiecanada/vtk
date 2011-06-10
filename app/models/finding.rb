class Finding < ActiveRecord::Base
	has_and_belongs_to_many :tasks,
							:join_table => :findings_tasks
	has_and_belongs_to_many :comps,
							:join_table => :findings_comps
	has_and_belongs_to_many :metrics,
							:join_table => :findings_metrics
	has_and_belongs_to_many :systems,
							:join_table => :findings_systems
	belongs_to :experiment
end
