class System < ActiveRecord::Base
	has_and_belongs_to_many :experiments,
							:join_table => :experiments_systems
	has_and_belongs_to_many :findings,
							:join_table => :findings_systems
end
