class PapersController < ApplicationController

	
  before_filter :authenticate_user!, 			:only => [:new, :create, :edit, :update, :destroy, :confirm_authors, :num_experiments, :doi]
  before_filter :authenticate_role, 			:only => [:edit, :update, :destroy, :confirm_authors, :num_experiments, :doi]
  
  def authenticate_role
	@paper = Paper.find(params[:id])
		
	if @paper.user_id != current_user.id && !current_user.admin # or is an admin...
		redirect_to paper_path(@paper), :notice => 'You do not have permission to do that.'
	end
  end
  
  
  #def index
	#@papers = Paper.all
  #end

  
  #def show
	#@paper = Paper.find(params[:id])
	#@paper.num_views += 1
	#@paper.save
	#@experiments = @paper.experiments.all
  #end

  
  def new
	@paper = current_user.papers.build
	@paper.num_views = 0
	@paper.status = 1
	@paper.save(:validate => false)
	redirect_to edit_paper_path(@paper,:type=>"new"), :notice => 'The first step in the entry process is to provide the publications details. All entries in the knowledgebase must be based on peer-reviewed, published research. Please begin by adding the authors, taking care to enter them in the appropriate order. Following, you can either provide the DOI to automate the remaining fields, or enter the information manually.'
  end

  def edit
	@paper_authors = @paper.author_papers.all
	@paper_author = @paper.author_papers.build
	@author = Author.new
	@authors = Author.all - Author.find(@paper_authors.map{|a| a.author_id})
	@authors = @authors.sort_by(&:last_name)
	if !params[:type].nil?
		@type = "new"
	else
		flash[:notice] = 'Edit publication details as you wish.'
	end
  end


  def update
	doi = params[:paper][:doi]
	
	if !doi.nil?
		require 'rubygems'
		require 'hpricot'
		require 'open-uri'
	
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
		redirect_to edit_paper_path(@paper)
	else
		if @paper.update_attributes(params[:paper]) && (@paper.authors.count > 0)
			if @paper.status == 1
				@paper.status = 2
				@paper.save
				redirect_to paper_experiments_path(@paper), :notice => 'You have successfully added the publication details! Now it is time to add the experiment details. If there are multiple experiments described in this publication you will want to add each experiment individually. To make the entry process easier you will first choose whether you are adding a CONTROLLED or PRACTICAL experiment. {more} After providing the basic details we will ask you to describe the user tasks and findings specific to the experiment.'
			#elsif @paper.status == 2
			#	redirect_to paper_experiments_path(@paper)
			#elsif @paper.status == 3
			#	redirect_to review_path(:id => @paper.id), :notice => 'Publication details were successfully updated.'
			else
				redirect_to paper_experiments_path(@paper), :notice => 'Publication details were successfully updated.'
			end
		else
			if @paper.authors.count == 0
				@paper.errors.add_to_base("The entry must have at least one author.")
			end
			redirect_to edit_paper_path(@paper)
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
	
	#if current_user.admin
	#	redirect_to admin_path, :notice => 'Entry was successfully deleted.'
	#else
		redirect_to root_path, :notice => 'Entry was successfully deleted.'
	#end
  end
  
  
  #def add_authors
  	#@paper = Paper.find(params[:id])
	#@paper_authors = @paper.author_papers.all
	#@paper_author = @paper.author_papers.build
	#@authors = Author.all - Author.find(@paper_authors.map{|a| a.author_id})
	#@authors = @authors.sort_by(&:last_name)
  #end
  
  
  def review
	@paper = Paper.find(params[:id])
	#if (@paper.status != 3)
	#	@paper.status = 3
	#	@paper.save
	flash[:notice] = 'Please look over your entry to ensure the details are correct. You can filter through the tabs above to see the experiments, user tasks, and findings structure, and follow any of the links to add, edit or delete details. Once you are done finalizing the entry, hit "Submit" and it will become active on the knowledgebase.'
	#end
  end
  
  
  def confirm
	@paper = Paper.find(params[:id])
	@paper.status = 0
	@paper.save
	redirect_to paper_path(@paper), :notice => 'Submission complete! Thank you for your entry.'
  end
  
end
