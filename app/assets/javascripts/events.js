$(function(){
	$("#event_date").datepicker({
			onClose: function(dateText, inst) { $(inst.input).change().focusout(); }, 
			autoSize: true, 
			dateFormat: 'dd-M-yy',
			changeMonth: true,
    	changeYear: true
		});
});

/*
* DZF when starts_at select value is higher than ends_at, this function sets ends_at value 1 hour higher
*/
function check_event_hour(){
	if ( $('#event_starts_at_4i').val() >= $('#event_ends_at_4i').val() && $('#event_ends_at_4i').val().length > 0) {
			var number = parseInt( $('#event_starts_at_4i').val() )+ 1;
			if (number.toString().length == 1){
				if ( parseInt( $('#event_starts_at_4i').val()) != 0) {
					$('#event_ends_at_4i').val("0"+number.toString());
				} else {
					$('#event_ends_at_4i').val(number.toString()+"0");
				}
			} else {
				$('#event_ends_at_4i').val(parseInt( $('#event_starts_at_4i').val() )+ 1);	
			}
	}
}
/*
*DZF thi function blok the starts and ends selects when all_day is checked
*/
function event_day_status() {
	if( $("#event_all_day").is(":checked")){
		block_hours_event();
	} else {
		unblock_hours_event();
	}

	function unblock_hours_event(){
		$('#event_starts_at_4i').attr('disabled', false);
		$('#event_starts_at_5i').attr('disabled', false);
		$('#event_ends_at_4i').attr('disabled', false);		
		$('#event_ends_at_5i').attr('disabled', false);
	}
	function block_hours_event(){
		$('#event_starts_at_4i').attr('disabled', true);
		$('#event_starts_at_5i').attr('disabled', true);
		$('#event_ends_at_4i').attr('disabled', true);		
		$('#event_ends_at_5i').attr('disabled', true);
	}
}
