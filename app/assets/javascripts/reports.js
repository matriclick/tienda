$(function() {
  $("#from").datepicker({ dateFormat: 'yy-mm-dd', firstDay: 1 });
  $("#to").datepicker({ dateFormat: 'yy-mm-dd', firstDay: 1 });
});

function update_amount_to_pay(sa_id, cost, id) {
	cummulative_cost = document.getElementById(sa_id).innerHTML;
	check_box = document.getElementById(id);
			
	if(check_box.checked) {
		document.getElementById(sa_id).innerHTML = parseInt(cummulative_cost) + parseInt(cost);		
	} else {
		document.getElementById(sa_id).innerHTML = parseInt(cummulative_cost) - parseInt(cost);		
	}

}