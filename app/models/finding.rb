class Finding < ActiveRecord::Base
	acts_as_indexed :fields => [:finding, :issues, :paper_title, :paper_year, :authors,  :exp_task, :find_comps, :find_tasks, :find_systems, :find_metrics, :exp_details, :paper_journal]
		
	has_and_belongs_to_many :tasks,
							:join_table => :findings_tasks
	has_and_belongs_to_many :comps,
							:join_table => :findings_comps
	has_and_belongs_to_many :metrics,
							:join_table => :findings_metrics
	has_and_belongs_to_many :systems,
							:join_table => :findings_systems
	belongs_to :experiment

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

	def exp_task
		experiment.task_desc
	end
	
	def exp_details
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
			experiment.other
		end
	end
	
	def paper_title
		Paper.find(experiment.paper_id).title
	end
	
	def paper_journal
		Paper.find(experiment.paper_id).journal
	end
	
	def paper_year
		Paper.find(experiment.paper_id).year.strftime("%Y")
	end
	
	def authors
		Paper.find(experiment.paper_id).authors.each do |a|
			a.last_name + ' ' + a.first_name + ' '
		end
	end
end
