class Author < ActiveRecord::Base
	has_many	:author_papers, :dependent => :destroy
	has_many 	:papers, :through => :author_papers
	validates_presence_of 	:last_name, :first_name
end
