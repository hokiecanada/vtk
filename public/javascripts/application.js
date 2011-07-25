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
		document.getElementById("task_search_option").value = 'Task';
		document.getElementById("comp_search_option").value = 'Task';
		document.getElementById("metric_search_option").value = 'Task';
		document.getElementById("system_search_option").value = 'Task';
	}
	else if (option == 'Component of immersion')
	{
		document.getElementById("task").style.display = 'none';
		document.getElementById("comp").style.display = 'block';
		document.getElementById("metric").style.display = 'none';
		document.getElementById("system").style.display = 'none';
		document.getElementById("task_search_option").value = 'Component of immersion';
		document.getElementById("comp_search_option").value = 'Component of immersion';
		document.getElementById("metric_search_option").value = 'Component of immersion';
		document.getElementById("system_search_option").value = 'Component of immersion';
	}
	else if (option == 'Metric')
	{
		document.getElementById("task").style.display = 'none';
		document.getElementById("comp").style.display = 'none';
		document.getElementById("metric").style.display = 'block';
		document.getElementById("system").style.display = 'none';
		document.getElementById("task_search_option").value = 'Metric';
		document.getElementById("comp_search_option").value = 'Metric';
		document.getElementById("metric_search_option").value = 'Metric';
		document.getElementById("system_search_option").value = 'Metric';
	}
	else
	{
		document.getElementById("task").style.display = 'none';
		document.getElementById("comp").style.display = 'none';
		document.getElementById("metric").style.display = 'none';
		document.getElementById("system").style.display = 'block';
		document.getElementById("task_search_option").value = 'System';
		document.getElementById("comp_search_option").value = 'System';
		document.getElementById("metric_search_option").value = 'System';
		document.getElementById("system_search_option").value = 'System';
	}
}

function search_results_display_as(option)
{
	if (option == 'findings')
	{
		document.getElementById("search_findings").style.display = 'block';
		document.getElementById("search_experiments").style.display = 'none';
		document.getElementById("search_papers").style.display = 'none';
	}
	else if (option == 'experiments')
	{
		document.getElementById("search_findings").style.display = 'none';
		document.getElementById("search_experiments").style.display = 'block';
		document.getElementById("search_papers").style.display = 'none';
	}
	else
	{
		document.getElementById("search_findings").style.display = 'none';
		document.getElementById("search_experiments").style.display = 'none';
		document.getElementById("search_papers").style.display = 'block';
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