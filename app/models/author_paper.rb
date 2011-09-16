class AuthorPaper < ActiveRecord::Base
	belongs_to	:author
	belongs_to	:paper
	attr_accessible :author_id, :paper_id, :order
end
