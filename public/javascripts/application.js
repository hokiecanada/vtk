function add_fields(link, association, content) {
	var new_id = new Date().getTime();
	var regexp = new RegExp("new_" + association, "g")
	$(link).up().insert({before: content.replace(regexp, new_id)});
}

function display_as(option)
{
	if (option == 'findings')
	{
		document.getElementById("search_findings").style.display = 'block';
		document.getElementById("search_experiments").style.display = 'none';
		document.getElementById("search_papers").style.display = 'none';
		document.getElementById("display_as").value = 'Findings';
	}
	else if (option == 'experiments')
	{
		document.getElementById("search_findings").style.display = 'none';
		document.getElementById("search_experiments").style.display = 'block';
		document.getElementById("search_papers").style.display = 'none';
		document.getElementById("display_as").value = 'Experiments';
	}
	else
	{
		document.getElementById("search_findings").style.display = 'none';
		document.getElementById("search_experiments").style.display = 'none';
		document.getElementById("search_papers").style.display = 'block';
		document.getElementById("display_as").value = 'Papers';

	}
}