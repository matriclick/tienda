function validate_attached_message(){
	$('form.attachednote_form').submit(function(){
		message_valid = validate_presence_custom("#" + $(this).find('textarea').attr('id'));
		if (!message_valid) {
			$('.select_loading').hide();
		};
		return message_valid;
	});
}