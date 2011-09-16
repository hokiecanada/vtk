class AuthorsPaper < ActiveRecord::Base
	belongs_to	:author
	belongs_to	:paper
end
