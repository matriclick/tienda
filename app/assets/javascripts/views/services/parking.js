$(function(){
	$("#service_price").onlyDigits();
	$("#service_top_price_range").onlyDigits();
});

function remove_service_price_zeros_on_left(){
	do{
		if($("#service_price").val().slice(0,1) == 0){
			$("#service_price").val($("#service_price").val().slice(1,($("#service_price").val().length)));
		}
  }
	while ($("#service_price").val().charAt(0) == 0 && $("#service_price").val().length > 0);
	if ($("#service_price").val().length == 0){
		$("#service_price").val(0);
	}
}

function remove_service_top_price_zeros_on_left(){
	do{
		if($("#service_top_price_range").val().slice(0,1) == 0){
			$("#service_top_price_range").val($("#service_top_price_range").val().slice(1,($("#service_top_price_range").val().length)));
		}
  }
	while ($("#service_top_price_range").val().charAt(0) == 0 && $("#service_top_price_range").val().length > 0);
	if ($("#service_top_price_range").val().length == 0){
		$("#service_top_price_range").val(0);
	}
}

function change_service_prices(){
	remove_service_price_zeros_on_left();
	remove_service_top_price_zeros_on_left();
	if (parseInt($("#service_top_price_range").val()) != 0 ){
		if (parseInt($("#service_top_price_range").val()) < parseInt($("#service_price").val())) {
			$("#service_top_price_range").val(parseInt($("#service_price").val())+1);
		}
	}
}

function set_service_prices_visibility(){
	if( $("#price_unique").is(':checked') ){
		$("#service_top_price_range").hide();
		$("#top_price_label").hide();
		$("#service_top_price_range").val(0);
	} else {
		$("#service_top_price_range").show();
		$("#top_price_label").show();
		$("#service_top_price_range").val($("#hidden_top_price_range").html());		
	}	
}

function change_check_box_value(){
	if ( $("#parking").is(":checked") ){
		$("#service_parking").attr('disabled', false);
		$("#parking").val("on");
	} else {
		$("#service_parking").attr('disabled', true)
		$("#parking").val("off");
	}
}

// TCT: Check the prices visibility when page loads.
$(function(){
	set_service_prices_visibility();
});

