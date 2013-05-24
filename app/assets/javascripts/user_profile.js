$(function() {	
	$('form#edit_user_account').submit(function() {

	});
});

$(function(){
	if ($('#user_account_campaign_user_account_info_attributes_description').length > 0) {
		limitText($('#user_account_campaign_user_account_info_attributes_description'), $('#limit_count'), 800);

		$('#user_account_campaign_user_account_info_attributes_description').keyup(function(){
			limitText($('#user_account_campaign_user_account_info_attributes_description'), $('#limit_count'), 800);
		});		
	};
});

function before_submit(){
	if ($(".field_with_errors").length > 0){
		/* the form has some errors*/
		return false;
	} else {
	 /* the form has not errors*/
	 $("a#publicity_hidden_link").trigger("click");
	}
}

function limitText(limitField, limitCount, limitNum) {
	if (limitField.val().length > limitNum) {
		limitField.val(limitField.val().substring(0, limitNum));
	} else {
		limitCount.html(limitNum - limitField.val().length);
	}
}