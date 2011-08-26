module ApplicationHelper
	def link_to_add_fields(name, f, association)
		new_object = f.object.class.reflect_on_association(association).klass.new
		fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
			render(association.to_s.singularize + "_fields", :f => builder)
		end
		link_to_function(name, "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")")
	end
	
	def button_to_add_fields(name, f, association)
		new_object = f.object.class.reflect_on_association(association).klass.new
		fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
			render("/forms/" + association.to_s.singularize + "_fields", :f => builder)
		end
		button_to_function(name, "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")")
	end
	
	def sortable_comp(title, column, search_comp, filter_tasks, filter_metrics, filter_systems, display_as, direction)
		#title ||= column.titleize
		#css_class = column == sort_column ? "current #{sort_direction}" : nil
		#direction = column == sort_column(display_as) && sort_direction == "asc" ? "desc" : "asc"
		link_to title, :search_comp => search_comp, :sort => column, :direction => direction, :filter_tasks => filter_tasks, :filter_metrics => filter_metrics, :filter_systems => filter_systems, :display_as => display_as
	end

	def sortable_task(title, column, search_task, filter_comps, filter_metrics, filter_systems, display_as, direction)
		#title ||= column.titleize
		#css_class = column == sort_column ? "current #{sort_direction}" : nil
		#direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
		link_to title, :search_task => search_task, :sort => column, :direction => direction, :filter_comps => filter_comps, :filter_metrics => filter_metrics, :filter_systems => filter_systems, :display_as => display_as
	end
	
	def sortable_metric(column, search_comp, filter_comps, filter_tasks, filter_systems, display_as)
		title ||= column.titleize
		#css_class = column == sort_column ? "current #{sort_direction}" : nil
		direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
		link_to title, :search_comp => search_comp, :sort => column, :direction => direction, :filter_comps => filter_comps, :filter_tasks => filter_tasks, :filter_systems => filter_systems, :display_as => display_as
	end
	
	def sortable_system(column, search_comp, filter_comps, filter_tasks, filter_metrics, display_as)
		title ||= column.titleize
		#css_class = column == sort_column ? "current #{sort_direction}" : nil
		direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
		link_to title, :search_comp => search_comp, :sort => column, :direction => direction, :filter_comps => filter_comps, :filter_tasks => filter_tasks, :filter_metrics => filter_metrics, :display_as => display_as
	end
end
