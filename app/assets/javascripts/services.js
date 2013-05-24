function address_status(){
	if ($("#service_deliverable").is(":checked")){
		$(".address_tr").hide();		
		$("#service_deliverable").val(1);
		$("#parking_field").hide();
		
	
	 $("#service_address, #service_commune").closest('td').find('.field_with_errors').each(function(){$(this).removeClass('field_with_errors')});
 	 $("#service_address, #service_commune").next("label.message").remove();
 			
	} else{
		$(".address_tr").show();
		$("#service_deliverable").val(0);
		$("#parking_field").show();
	}
}


function check_service_type(select_value, not_deliverable_services_ids){		
	var service_deriverable = true;			
	for (i=0;i<=not_deliverable_services_ids.length ;i++){
		if (select_value.value == not_deliverable_services_ids[i]){
			$("#service_deliverable").removeAttr('checked');
			 address_status();
			 service_deriverable = false;
		}	
	}
	if(service_deriverable){	
		$("#service_deliverable").attr('checked','checked');
		address_status();	
	} 	
}

// FGM: Check even before user changes select.
$(function(){
	address_status();
});
//TCT: Remove error labels for allowing submiting the form after validation
$(function(){
	$("#service_address").blur(function(){
	if($(this).val()){
	 $(this).closest('td').find('.field_with_errors').each(function(){$(this).removeClass('field_with_errors')});
 	 $(this).next("label.message").remove();}	});
	$("#service_commune").blur(function(){
	if($(this).val()){
	 $(this).closest('td').find('.field_with_errors').each(function(){$(this).removeClass('field_with_errors')});
 	 $(this).next("label.message").remove();}	});
				
});
