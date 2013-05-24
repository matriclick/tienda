/*# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/*/

function validate_reference_request(){
	$('#reference_request_new').submit(function(){
		message_valid = validate_presence_custom("#reference_request_content");

		return message_valid;
	});
}
