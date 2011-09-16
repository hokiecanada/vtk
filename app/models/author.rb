class Author < ActiveRecord::Base
	has_many	:author_papers
	has_many 	:papers, :through => :author_papers
end
