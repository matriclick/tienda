/* Bookable check_box logic */
$(function(){
		if ($('#supplier_account_bookable').is(":checked")) {
			$('#bookable_settings').fadeIn();
		} else {
			$('#bookable_settings').fadeOut();
		}
	
	$('#supplier_account_bookable').click(function(){
		if ($('#supplier_account_bookable').is(":checked")) {
			$('#bookable_settings').fadeIn();
		} else {
			$('#bookable_settings').fadeOut();
		}
	});
});

$(function(){
filter_regions('supplier_account_address_attributes');
});