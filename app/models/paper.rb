class Paper < ActiveRecord::Base
	acts_as_indexed :fields => [:title, :year, :journal, :paper_auths, :exp_task, :exp_details, :paper_exp_finds, :exp_comps, :exp_tasks, :exp_systems, :exp_metrics]
	has_and_belongs_to_many			:authors
	belongs_to						:user
	has_many						:experiments, :dependent => :destroy
	accepts_nested_attributes_for	:authors, :reject_if => :all_blank, :allow_destroy => true;
	
	def paper_auths
		authors.each do |a|
			a.last_name + ' ' + a.first_name + ' '
		end
	end
	
	def exp_task
		experiments.each do |e|
			e.task_desc + ' '
		end
	end
	
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
				f.finding + ' '
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
end
