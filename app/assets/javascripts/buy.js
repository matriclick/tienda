$(function(){
	$(".buy_radio_button").on("change", function(){
		$("#purchase_quantity").empty();
		var limit = 5;
		if (typeof(stocks_for_js[$(this).attr('id')]) != "undefined"){
			limit = stocks_for_js[$(this).attr('id')];
		}
		for (var i = 1; i <= limit; i++){
			var option = $('<option></option>').attr("value", i).text(i);
			$("#purchase_quantity").append(option);
		}
	});
});

$(function(){
	$(".buy_radio_button_cart").on("change", function(){
		if ($(this).is(':checked')){
			var shopping_cart_item_id = $(this).attr('id').match("shopping_cart_items_(.*)_size")[1];
			$("#shopping_cart_items_" + shopping_cart_item_id + "_quantity").empty();
			var limit = 5;
			if (typeof(stocks_for_js[shopping_cart_item_id][$(this).attr('id')]) != "undefined"){
				limit = stocks_for_js[shopping_cart_item_id][$(this).attr('id')];
			}
			for (var i = 1; i <= limit; i++){
				var option = $('<option></option>').attr("value", i).text(i);
				$("#shopping_cart_items_" + shopping_cart_item_id + "_quantity").append(option);
			}
		}
	});
	
});

