$("#edit_event_form").ready(function(){
	var event_date = $("#event_date").val(); // document.getElementById("event_date")
	var new_date = new Date();
	new_date.setFullYear(event_date.substring(0,4),event_date.substring(5,7)-1,event_date.substring(8));
	$("#event_date").val( new_date.toString().substring(8,10)+"-"+new_date.toString().substring(4,7)+"-"+new_date.toString().substring(11,15) );
});
