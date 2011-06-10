class Paper < ActiveRecord::Base
	has_and_belongs_to_many			:authors
	belongs_to						:user
	has_many						:experiments
	accepts_nested_attributes_for	:authors, :reject_if => :all_blank
end
