class Finding < ActiveRecord::Base
	acts_as_indexed :fields => [:finding, :issues, :paper_title, :paper_year, :authors, :find_comps, :find_tasks, :find_systems, :find_metrics, :exp_details, :paper_journal]
		
	has_and_belongs_to_many :tasks,
							:join_table => :findings_tasks
	has_and_belongs_to_many :comps,
							:join_table => :findings_comps
	has_and_belongs_to_many :metrics,
							:join_table => :findings_metrics
	has_and_belongs_to_many :systems,
							:join_table => :findings_systems
	belongs_to :experiment
	belongs_to :exp_task

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

	#def find_exp_tasks
	#	experiment.exp_tasks.each do |t|
	#		t.task_desc + ' '
	#	end
	#end
	
	def exp_details
		if !exp_task.interface_desc.nil?
			exp_task.interface_desc + ' '
		end
		if !exp_task.env_desc.nil?
			exp_task.env_desc + ' '
		end
		if !exp_task.experiment.part_background.nil?
			exp_task.experiment.part_background + ' '
		end
		if !exp_task.experiment.part_other.nil?
			exp_task.experiment.part_other + ' '
		end
		if !exp_task.experiment.systems_desc.nil?
			exp_task.experiment.systems_desc + ' '
		end
		if !exp_task.experiment.systems_tech.nil?
			exp_task.experiment.systems_tech + ' '
		end
		if !exp_task.experiment.comps_desc.nil?
			exp_task.experiment.comps_desc + ' '
		end
		if !exp_task.experiment.variables_desc.nil?
			exp_task.experiment.variables_desc + ' '
		end
		if !exp_task.experiment.constants.nil?
			exp_task.experiment.constants + ' '
		end
		if !exp_task.experiment.other.nil?
			exp_task.experiment.other
		end
	end
	
	def paper_title
		Paper.find(exp_task.experiment.paper_id).title
	end
	
	def paper_journal
		Paper.find(exp_task.experiment.paper_id).journal
	end
	
	def paper_year
		Paper.find(exp_task.experiment.paper_id).year.strftime("%Y")
	end
	
	def authors
		Paper.find(exp_task.experiment.paper_id).authors.each do |a|
			a.last_name + ' ' + a.first_name + ' '
		end
	end
end
