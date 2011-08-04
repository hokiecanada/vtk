function add_fields(link, association, content) {
	var new_id = new Date().getTime();
	var regexp = new RegExp("new_" + association, "g")
	$(link).up().insert({before: content.replace(regexp, new_id)});
}

function search_type(option)
{
	if (option == 'Task')
	{
		document.getElementById("task").style.display = 'block';
		document.getElementById("comp").style.display = 'none';
		document.getElementById("metric").style.display = 'none';
		document.getElementById("system").style.display = 'none';
		document.getElementById("search_option").value = 'Task';
	}
	else if (option == 'Component of immersion')
	{
		document.getElementById("task").style.display = 'none';
		document.getElementById("comp").style.display = 'block';
		document.getElementById("metric").style.display = 'none';
		document.getElementById("system").style.display = 'none';
		document.getElementById("search_option").value = 'Component of immersion';
	}
	else if (option == 'Metric')
	{
		document.getElementById("task").style.display = 'none';
		document.getElementById("comp").style.display = 'none';
		document.getElementById("metric").style.display = 'block';
		document.getElementById("system").style.display = 'none';
		document.getElementById("search_option").value = 'Metric';
	}
	else
	{
		document.getElementById("task").style.display = 'none';
		document.getElementById("comp").style.display = 'none';
		document.getElementById("metric").style.display = 'none';
		document.getElementById("system").style.display = 'block';
		document.getElementById("search_option").value = 'System';
	}
}

function search_results_display_as(option)
{
	if (option == 'findings')
	{
		document.getElementById("search_findings").style.display = 'block';
		document.getElementById("search_experiments").style.display = 'none';
		document.getElementById("search_papers").style.display = 'none';
		document.getElementById("filter_display_as").value = 'Findings';
		document.getElementById("task_display_as").value = 'Findings';
		document.getElementById("comp_display_as").value = 'Findings';
		document.getElementById("metric_display_as").value = 'Findings';
		document.getElementById("system_display_as").value = 'Findings';
	}
	else if (option == 'experiments')
	{
		document.getElementById("search_findings").style.display = 'none';
		document.getElementById("search_experiments").style.display = 'block';
		document.getElementById("search_papers").style.display = 'none';
		document.getElementById("filter_display_as").value = 'Experiments';
		document.getElementById("task_display_as").value = 'Experiments';
		document.getElementById("comp_display_as").value = 'Experiments';
		document.getElementById("metric_display_as").value = 'Experiments';
		document.getElementById("system_display_as").value = 'Experiments';
	}
	else
	{
		document.getElementById("search_findings").style.display = 'none';
		document.getElementById("search_experiments").style.display = 'none';
		document.getElementById("search_papers").style.display = 'block';
		document.getElementById("filter_display_as").value = 'Papers';
		document.getElementById("task_display_as").value = 'Papers';
		document.getElementById("comp_display_as").value = 'Papers';
		document.getElementById("metric_display_as").value = 'Papers';
		document.getElementById("system_display_as").value = 'Papers';
	}
}

function browse_results_display_as(option)
{
	if (option == 'findings')
	{
		document.getElementById("browse_findings").style.display = 'block';
		document.getElementById("browse_experiments").style.display = 'none';
		document.getElementById("browse_papers").style.display = 'none';
		document.getElementById("display_as").value = 'Findings';
	}
	else if (option == 'experiments')
	{
		document.getElementById("browse_findings").style.display = 'none';
		document.getElementById("browse_experiments").style.display = 'block';
		document.getElementById("browse_papers").style.display = 'none';
		document.getElementById("display_as").value = 'Experiments';
	}
	else
	{
		document.getElementById("browse_findings").style.display = 'none';
		document.getElementById("browse_experiments").style.display = 'none';
		document.getElementById("browse_papers").style.display = 'block';
		document.getElementById("display_as").value = 'Papers';
	}
}

function manage_filters(option)
{
	if (option == 'Task')
	{
		document.getElementById("task").style.display = 'block';
		document.getElementById("comp").style.display = 'none';
		document.getElementById("metric").style.display = 'none';
		document.getElementById("system").style.display = 'none';
	}
	else if (option == 'Component of immersion')
	{
		document.getElementById("task").style.display = 'none';
		document.getElementById("comp").style.display = 'block';
		document.getElementById("metric").style.display = 'none';
		document.getElementById("system").style.display = 'none';
	}
	else if (option == 'Metric')
	{
		document.getElementById("task").style.display = 'none';
		document.getElementById("comp").style.display = 'none';
		document.getElementById("metric").style.display = 'block';
		document.getElementById("system").style.display = 'none';
	}
	else
	{
		document.getElementById("task").style.display = 'none';
		document.getElementById("comp").style.display = 'none';
		document.getElementById("metric").style.display = 'none';
		document.getElementById("system").style.display = 'block';
	}	
}