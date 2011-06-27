class Relationship < ActiveRecord::Base
	has_and_belongs_to_many :findings,
							:join_table => :findings_relationships
end
