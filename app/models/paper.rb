class Paper < ActiveRecord::Base
	acts_as_indexed :fields => [:title, :year, :journal]#, :exp_details, :paper_exp_finds, :exp_comps, :exp_tasks, :exp_systems, :exp_metrics]
	has_many						:author_papers, :dependent => :destroy
	has_many						:authors, :through => :author_papers
	belongs_to						:user
	has_many						:experiments, :dependent => :destroy
	#accepts_nested_attributes_for	:authors, :reject_if => :all_blank, :allow_destroy => true
	accepts_nested_attributes_for	:author_papers
	
	validates_presence_of :title, :year#, :author
	#validate :correct_doi
	
	#def correct_doi
	#	require 'rubygems'
	#	require 'hpricot'
	#	require 'open-uri'
		
	#	if !doi.nil?
	#		doc = Hpricot(open("http://www.crossref.org/openurl/?pid=cstinson@vt.edu&id=doi:" + doi + "&noredirect=true"))
	#		str = doc.at("body").inner_html
	#		if str.include?("Malformed DOI")
	#			errors.add(:doi,"is invalid")
	#		end
	#	end
	#end
	
	#def author
	#	if author_papers.size == 0
	#		#flash[:notice] => 'Need to include at least one author'
	#		return false
	#	end
	#end
	
	##def paper_auths
	##	authors.each do |a|
	##		a.last_name + ' ' + a.first_name + ' '
	##	end
	##end
	
	#def exp_task
	#	experiments.each do |e|
	#		if !e.task_desc.nil?
	#			e.task_desc + ' '
	#		end
	#	end
	#end
	
=begin
	def exp_details
		experiments.each do |experiment|
			if !experiment.interface_desc.nil?
				experiment.interface_desc + ' '
			end
			if !experiment.env_desc.nil?
				experiment.env_desc + ' '
			end
			if !experiment.part_background.nil?
				experiment.part_background + ' '
			end
			if !experiment.part_other.nil?
				experiment.part_other + ' '
			end
			if !experiment.systems_desc.nil?
				experiment.systems_desc + ' '
			end
			if !experiment.systems_tech.nil?
				experiment.systems_tech + ' '
			end
			if !experiment.comps_desc.nil?
				experiment.comps_desc + ' '
			end
			if !experiment.variables_desc.nil?
				experiment.variables_desc + ' '
			end
			if !experiment.constants.nil?
				experiment.constants + ' '
			end
			if !experiment.other.nil?
				experiment.other + ' '
			end
		end
	end
	
	def paper_exp_finds
		experiments.each do |e|
			e.findings.each do |f|
				if !f.finding.nil?
					f.finding + ' '
				end
			end
		end
	end
	
	def exp_comps
		experiments.each do |e|
			e.comps.each do |c|
				c.comp_tag + ' '
			end
		end
	end
	
	def exp_tasks
		experiments.each do |e|
			e.tasks.each do |t|
				t.task_tag + ' '
			end
		end
	end
	
	def exp_systems
		experiments.each do |e|
			e.systems.each do |s|
				s.system_tag + ' '
			end
		end
	end
	
	def exp_metrics
		experiments.each do |e|
			e.metrics.each do |m|
				m.metric_tag + ' '
			end
		end
	end
=end

end
