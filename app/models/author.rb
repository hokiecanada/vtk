class Author < ActiveRecord::Base
	has_many	:author_papers, :dependent => :destroy
	has_many 	:papers, :through => :author_papers
end
