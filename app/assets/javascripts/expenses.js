function filter_supplier_accounts(type){
	$(".numeric").numeric();
	var ic_select = '#'+type+'_industry_category_id';
	var ic_text_field = '#'+type+'_industry_category_name';
	var sa_select = '#'+type+'_supplier_account_id';
	var sa_text_field = '#'+type+'_supplier_account_fantasy_name';
	var price = '#'+type+'_price';
	var quantity = '#'+type+'_quantity';
	var payed_percentage = '#'+type+'_payed_percentage';
	var payer0 = "#"+type+"_payers_attributes_0_percentage";
	var payer1 = "#"+type+"_payers_attributes_1_percentage";
	var payer2 = "#"+type+"_payers_attributes_2_percentage";
	var payer3 = "#"+type+"_payers_attributes_3_percentage";
	var payer4 = "#"+type+"_payers_attributes_4_percentage";
	var payers = [payer0, payer1, payer2, payer3, payer4];
	var non_blank_attributes = [price, quantity, payed_percentage];
		
	// FMG: Select IndustryCategory change event
	$(ic_select).change(function(){
		
		// FGM: Fetch IndustryCategory id
		val = $(ic_select + ' :selected').val();
		
		// FGM: Blank means "Other..." for IndustryCategory. Then show fields for custom IndustryCategory & SupplierAccount
		if (val == "") {
			$(ic_text_field).closest('td').fadeIn();
			$(sa_text_field).closest('td').fadeIn();
			$(sa_select).closest('td').hide();

		// FGM: Hide fields otherwise and fetch corresponding SupplierAccounts according to IndustryCategory
		} else {
			$(ic_text_field).closest('td').hide();
			$(sa_text_field).closest('td').hide();
			
		// FGM: AJAX request for SupplierAccounts belonging to IndustryCategory
			$.ajax({
				url: "/expenses/filter_supplier_accounts",
				data: "id=" + val,
				beforeSend: function(){
					$('img.select_loading').show();
				},
			  success: function(data) {
					$('img.select_loading').hide();
					
					var html = '<option value="">' + "Proveedor" + '</option>';
					html += '<option value="">' + "Otro..." + '</option>';
			    var len = data.length;
			
			// FGM: Populate Selector for SupplierAccount with results
					if (len > 0) {
				    for (var i = 0; i < len; i++) {
				        html += '<option value="' + data[i].id + '">' + data[i].name + '</option>';
				    }
						$(sa_select).closest('td').fadeIn();
				    $(sa_select).html(html);
						
					} else {
			// FGM: Otherwise, show text_field
						$(sa_select).closest('td').hide();
						$(sa_text_field).closest('td').fadeIn();
					}
	    	}
	  	});
		}
	});
	listen_sa_select(sa_select, sa_text_field);
	
	// FGM: Trigger validation on submit
	$(ic_text_field).closest('form').submit(function(){
		ic_valid = validate_presence_of_select_and_text_field(ic_select, ic_text_field);
		sa_valid = validate_presence_of_select_and_text_field(sa_select, sa_text_field);
		price_valid = validate_presence(price);
		quantity_valid = validate_presence(quantity);
		payed_percentage_valid = validate_presence(payed_percentage) && validate_percentage_cant_exceed_100(payed_percentage);
		payers_percentage_valid = validate_must_sum_100(payers);
		
		if (type == "expense") {
			return ic_valid && sa_valid && price_valid && quantity_valid && payed_percentage_valid && payers_percentage_valid;	
		} else if (type == "budget") {
			return ic_valid && sa_valid && price_valid
		}
		
	});
	
	// FGM: Trigger validation for IndustryCategory
	$(ic_text_field).blur(function(){
		validate_presence_of_select_and_text_field(ic_select, ic_text_field);
	});
	
	// FGM: Trigger validation for SupplierAccount
	$(sa_text_field).blur(function(){
		validate_presence_of_select_and_text_field(sa_select, sa_text_field);
	});
	
	// FGM: Trigger validations for PRICE, QUANTITY, PAYED PERCENTAGE
	$.each(non_blank_attributes, function(index, value){
		$(value).blur(function(){
			validate_presence(value);
		});
	});
	
	// FGM: Trigger payed percentage validation
	$(payed_percentage).blur(function(){
		validate_percentage_cant_exceed_100(payed_percentage);
	});
}

function listen_sa_select(select, text_field){
	$(select).change(function(){
		val = $(select + ' :selected').val();
		
		if (val == "") {
			$(text_field).closest('td').fadeIn();
		} else {
			$(text_field).closest('td').hide();
		}
	});
}

// FGM: Validation!
function validate_presence_of_select_and_text_field(select, text_field){
	select_value = $(select + ' :selected').val();
	text_field_value = $(text_field).val();
	
	// FGM: INVALID
	if (select_value == "" && text_field_value == "") {
		display_invalid_label(text_field, "No puede estar en blanco");
		return false;
	} else {
		hide_invalid_label(text_field);
		return true;
	}
}

function validate_presence(object){
	if ($(object).val() == ""){
		display_invalid_label(object, "No puede estar en blanco");
		return false;
	} else {
		hide_invalid_label(object);
		return true;
	}
}

function validate_percentage_cant_exceed_100(object){
	if ($(object).val() > 100) {
		display_invalid_label(object, "No puede exceder 100");
		return false;
	} else {
		hide_invalid_label(object);
		return true;
	}
}

function validate_must_sum_100(arr){
	var sum = 0.0;
	$.each(arr, function(i, v){
		if ($(v).val() != "") {
			sum += parseFloat($(v).val());	
		};
	});
	if (sum != 100) {
		display_invalid_label(arr[0], "Debe sumar 100", ".error_field_target");
		return false;
	} else {
		hide_invalid_label(arr[0], ".error_field_target");
		return true;
	}
}

function display_invalid_label(label, message, object) {
	if (object) {
		var target = $(object);
	} else {
		var target = $(label).siblings('label');
		target.closest('tr').fadeIn();	
	}
	
	if (target.next('span.invalid_next_to_label').length == 0) {
		target.after("<span class='invalid_next_to_label'>" + message + "</span>");	
	}
}

function hide_invalid_label(label, object) {
	if (object) {
		var target = $(object);
	} else {
		var target = $(label).siblings('label');
	}
	
	if (target.next('span.invalid_next_to_label').length > 0) {
		target.next('span.invalid_next_to_label').remove();
	}
}

/* radio buttons logic */

function change_range_check_box_value(){
	if ( $("#range_half").is(":checked") ){
		$("#expense_payers_attributes_0_percentage").attr('value', 50 );
		$("#expense_payers_attributes_1_percentage").attr('value', 50 );
		$("#expense_payers_attributes_2_percentage").attr('value', 0 );
		$("#expense_payers_attributes_3_percentage").attr('value', 0 );
		$("#expense_payers_attributes_4_percentage").attr('value', 0 );
	}
	if ( $("#range_quarter").is(":checked") ){
		$("#expense_payers_attributes_0_percentage").attr('value', 25 );
		$("#expense_payers_attributes_1_percentage").attr('value', 25 );
		$("#expense_payers_attributes_2_percentage").attr('value', 25 );
		$("#expense_payers_attributes_3_percentage").attr('value', 25 );
		$("#expense_payers_attributes_4_percentage").attr('value', 0 );
	}
}
