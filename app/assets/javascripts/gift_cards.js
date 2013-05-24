$(function() {
  $("#gift_card_valid_from").datepicker({ dateFormat: 'yy-mm-dd', firstDay: 1 });
  $("#gift_card_valid_to").datepicker({ dateFormat: 'yy-mm-dd', firstDay: 1 });


	if($("#gift_card_valid_from").val() == "") {
		today = new Date();
		tpday_string = dateFormat(today, "yyyy-mm-dd");
		$("#gift_card_valid_from").val(tpday_string);
	}

});