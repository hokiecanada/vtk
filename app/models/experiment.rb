class Experiment < ActiveRecord::Base
	acts_as_indexed :fields => [:task_desc, :find_comps, :find_tasks, :find_systems, :find_metrics, :part_background,
								:part_other, :systems_tech, :systems_desc, :comps_desc, :variables_desc, :constants,
								:other, :env_desc, :interface_desc, :paper_title, :paper_journal, :paper_year, :paper_authors, :exp_finds]

	has_and_belongs_to_many :tasks,
							:join_table => :experiments_tasks
	has_and_belongs_to_many :comps,
							:join_table => :experiments_comps
	has_and_belongs_to_many :metrics,
							:join_table => :experiments_metrics
	has_and_belongs_to_many :systems,
							:join_table => :experiments_systems
	belongs_to :paper
	has_many :findings, :dependent => :destroy
	#accepts_nested_attributes_for	:tasks,
	#								:reject_if => :all_blank,
	#accepts_nested_attributes_for	:findings,
	#								:reject_if => :all_blank,
	#								:allow_destroy => true;
	
	def find_comps
		comps.each do |c|
			c.comp_tag + ' '
		end
	end
	
	def find_tasks
		tasks.each do |t|
			t.task_tag + ' '
		end
	end
	
	def find_metrics
		metrics.each do |m|
			m.metric_tag + ' '
		end
	end
	
	def find_systems
		systems.each do |s|
			s.system_tag + ' '
		end
	end
	
	def paper_title
		paper.title
	end
	
	def paper_journal
		paper.journal
	end
	
	def paper_year
		paper.year.strftime("%Y")
	end
	
	def paper_authors
		paper.authors.each do |a|
			a.last_name + ' ' + a.first_name
		end
	end
	
	def exp_finds
		findings.each do |f|
			if !f.finding.nil?
				f.finding + ' '
			end
		end
	end
	
end
