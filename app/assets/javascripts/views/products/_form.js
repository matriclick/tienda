$(function(){
	$("#product_price").onlyDigits();
	$("#product_top_price_range").onlyDigits();
});

function remove_product_price_zeros_on_left(){
	do{
		if($("#product_price").val().slice(0,1) == 0){
			$("#product_price").val($("#product_price").val().slice(1,($("#product_price").val().length)));
		}
  }
	while ($("#product_price").val().charAt(0) == 0 && $("#product_price").val().length > 0);
	if ($("#product_price").val().length == 0){
		$("#product_price").val(0);
	}
}

function remove_product_top_price_zeros_on_left(){
	do{
		if($("#product_top_price_range").val().slice(0,1) == 0){
			$("#product_top_price_range").val($("#product_top_price_range").val().slice(1,($("#product_top_price_range").val().length)));
		}
  }
	while ($("#product_top_price_range").val().charAt(0) == 0 && $("#product_top_price_range").val().length > 0);
	if ($("#product_top_price_range").val().length == 0){
		$("#product_top_price_range").val(0);
	}
} 

function set_prices_visibility(){
	if( $("#price_unique").is(':checked') ){
		$("#product_top_price_range").hide();
		$("#top_price_label").hide();
		$("#product_top_price_range").val(0);
	} else {
		$("#product_top_price_range").show();
		$("#top_price_label").show();
		$("#product_top_price_range").val($("#hidden_top_price_range").html());
	}	
}

// TCT: Check the prices visibility when page loads.
$(function(){
	set_prices_visibility();
});
