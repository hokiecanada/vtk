class Metric < ActiveRecord::Base
	has_and_belongs_to_many :experiments,
							:join_table => :experiments_metrics
	has_and_belongs_to_many :findings,
							:join_table => :findings_metrics
end
