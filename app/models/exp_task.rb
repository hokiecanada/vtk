class ExpTask < ActiveRecord::Base
  belongs_to :experiment
  has_many :findings
  has_and_belongs_to_many 	:tasks,
							:join_table => :exp_tasks_tasks
  has_and_belongs_to_many 	:metrics,
							:join_table => :exp_tasks_metrics
end
