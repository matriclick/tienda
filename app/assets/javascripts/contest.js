function vote(act_id) {
	alert('Hola')
	$.ajax({
		url: "/despedida-de-soltera/vote",
	    data: "id="+act_id,
	});
	if ($("div#titulo_"+act_id).css('text-decoration') === 'line-through') {
		$("div#titulo_"+act_id).css('text-decoration','none');
	} else {
		$("div#titulo_"+act_id).css('text-decoration','line-through');
	}
}