function validate_custom_booking(){
	$('#new_custom_booking').submit(function(){
		date_valid = validate_presence_custom("#booking_date");
		message_valid = validate_presence_custom("#booking_message");

		return date_valid && message_valid;
	});	
}

// FGM: TODO: DRY up custom presence validator
function validate_presence_custom(object){
	
	if ($(object).val() == ""){
		if ($(object).siblings('span.invalid_next_to_label').length == 0) {
			$(object).before("<span class='invalid_next_to_label'>No puede estar en blanco</span>");	
		}
		return false;
	} else {
		if ($(object).siblings('span.invalid_next_to_label').length > 0) {
			$(object).siblings('span.invalid_next_to_label').remove();
		}
		return true;
	}
}
