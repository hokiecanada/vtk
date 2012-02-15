class PapersController < ApplicationController

	
  before_filter :authenticate_user!, 			:only => [:new, :create, :edit, :update, :destroy, :confirm_authors, :num_experiments, :doi]
  before_filter :authenticate_role, 			:only => [:edit, :update, :destroy, :confirm_authors, :num_experiments, :doi]
  
  def authenticate_role
	@paper = Paper.find(params[:id])
		
	if @paper.user_id != current_user.id && !current_user.admin # or is an admin...
		redirect_to paper_path(@paper), :notice => 'You do not have permission to do that.'
	end
  end
  
  
  def index
	@papers = Paper.all
  end

  
  def show
	@paper = Paper.find(params[:id])
	@paper.num_views += 1
	@paper.save
	@experiments = @paper.experiments.all
  end

  
  def new
	@paper = current_user.papers.build
	@paper.num_views = 0
	@paper.status = 1
	@paper.save(:validate => false)
	@paper_authors = @paper.author_papers.all
	@paper_author = @paper.author_papers.build
	@author = Author.new
	@authors = Author.all - Author.find(@paper_authors.map{|a| a.author_id})
	@authors = @authors.sort_by(&:last_name)
	render :action => "edit"
  end

  def edit
	@paper_authors = @paper.author_papers.all
	@paper_author = @paper.author_papers.build
	@author = Author.new
	@authors = Author.all - Author.find(@paper_authors.map{|a| a.author_id})
	@authors = @authors.sort_by(&:last_name)
  end


  def update
  	require 'rubygems'
	require 'hpricot'
	require 'open-uri'
	
	doi = params[:paper][:doi]
	
	if !doi.nil?
		doi = doi.strip
		if doi.include?("http://dx.doi.org/")
			doi = doi.sub("http://dx.doi.org/","")
		end
		
		if doi != ""
			doc = Hpricot(open("http://www.crossref.org/openurl/?pid=cstinson@vt.edu&id=doi:" + doi + "&noredirect=true"))
			str = doc.at("body").inner_html
			
			if !str.include?("Malformed DOI")		
				if !(doc.search("//article_title").first).nil?
					@paper.title = doc.search("//article_title").first.inner_html
				end
				
				if !(doc.search("//year").first).nil?
					@paper.year = Date.parse(doc.search("//year").first.inner_html + "-01-01")
				end
				
				if !(doc.search("//journal_title").first).nil?
					@paper.journal = (doc/"journal_title").inner_html
				end
				
				if !(doc.search("//volume").first).nil?
					@paper.volume = (doc/"volume").inner_html.to_i()
				end
				
				if !(doc.search("//journal_title").first).nil?
					@paper.number = (doc/"issue").inner_html.to_i()
				end
				
				if !(doc.search("//first_page").first).nil? && !(doc.search("//last_page").first).nil?
					first = doc.search("//first_page").inner_html
					last = doc.search("//last_page").inner_html
					@paper.first_page = first + '-' + last
				end
				
				@paper.paper_url = "http://dx.doi.org/" + doi
				@paper.doi = doi
				@paper.save
				flash[:notice] = "DOI details acquired successfully"
			else
				#@paper.save(:validate => false)
				@paper.errors.add(:doi, "is invalid")
			end
		else
			@paper.errors.add(:doi, "is empty")
		end
		@paper_authors = @paper.author_papers.all
		@paper_author = @paper.author_papers.build
		@author = Author.new
		@authors = Author.all - Author.find(@paper_authors.map{|a| a.author_id})
		@authors = @authors.sort_by(&:last_name)
		render :action => :edit
	else
		if @paper.update_attributes(params[:paper]) && (@paper.authors.count > 0)
			if @paper.status == 1
				@paper.status = 2
				@paper.save
				redirect_to paper_experiments_path(@paper)
			elsif @paper.status == 2
				redirect_to paper_experiments_path(@paper)
			elsif @paper.status == 3
				redirect_to review_path(:id => @paper.id), :notice => 'Publication details were successfully updated.'
			else
				redirect_to @paper, :notice => 'Publication was successfully updated.'
			end
		else
			if @paper.authors.count == 0
				@paper.errors.add_to_base("The entry must have at least one author.")
			end
			@paper_authors = @paper.author_papers.all
			@paper_author = @paper.author_papers.build
			@author = Author.new
			@authors = Author.all - Author.find(@paper_authors.map{|a| a.author_id})
			@authors = @authors.sort_by(&:last_name)
			render :action => "edit"
		end
	end
  end
  
  
  def destroy
    authors = Author.where(:id => @paper.authors)
	@paper.destroy
	authors.each do |a|
		if a.papers.size == 0
			a.destroy
		end
	end
	
	if current_user.admin
		redirect_to admin_path, :notice => 'Entry was successfully deleted.'
	else
		redirect_to root_path, :notice => 'Entry was successfully deleted.'
	end
  end
  
  
  def add_authors
  	@paper = Paper.find(params[:id])
	@paper_authors = @paper.author_papers.all
	@paper_author = @paper.author_papers.build
	@authors = Author.all - Author.find(@paper_authors.map{|a| a.author_id})
	@authors = @authors.sort_by(&:last_name)
  end
  
  
  def review
	@paper = Paper.find(params[:id])
	if (@paper.status != 3)
		@paper.status = 3
		@paper.save
	end
  end
  
  
  def confirm
	@paper = Paper.find(params[:id])
	@paper.status = 0
	@paper.save
	redirect_to paper_path(@paper), :notice => 'Submission complete! Thank you for your entry.'
  end
  
  
  private
  
  def parse_DOI()
    doc = Hpricot(open("http://www.crossref.org/openurl/?id=doi:#{doi}&noredirect=true&pid=ourl_sample:sample&format=unixref"))

    journal = (doc/"abbrev_title").inner_html
    year = (doc/"journal_issue/publication_date/year").inner_html
    volume = (doc/"journal_issue/journal_volume/volume").inner_html
    number = (doc/"journal_issue/issue").inner_html
    first_page = (doc/"pages/first_page").inner_html
    last_page = (doc/"pages/last_page").inner_html

    "#{journal} #{year}, #{volume}(#{number}) #{first_page}-#{last_page}"
  end
  
end
