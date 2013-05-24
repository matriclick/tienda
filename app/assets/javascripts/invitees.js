function filter_regions(prev_id) {
  var communes; 

  communes = $('#'+prev_id+'_commune_id').html();
	
  $('#'+prev_id+'_region_id').change(
		function() {
    	var escaped_region, options, region;
			region = $('#'+prev_id+'_region_id :selected').text();
    	escaped_region = region.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1');
    	options = $(communes).filter("optgroup[label='" + escaped_region + "']").html();

			if (options) {$('#'+prev_id+'_commune_id').html(options).parent().show();} 
			else { $('#'+prev_id+'_commune_id').html(communes).parent().show(); }
  	}); 

}


$(function () {  
  // Sorting and pagination links.  
  $('#invitees th a, #invitees .pagination a').live('click',   
    function () {  
      $.getScript(this.href);  
      return false;			
    }  
  );  
    
  // Search form.  
  $('#invitees_search').submit(function () {  
    $.get(this.action, $(this).serialize(), null, 'script');  
     return false; 
  });

	// FGM: All input with class='numeric' implement NUMERIC plugin
	$(".numeric").numeric();
});



function store_values(){

	parent.previous_string_values[0] = $('#invitee_name').val();
	parent.previous_string_values[1] = $('#invitee_lastname_p').val();
	parent.previous_string_values[2] = $('#invitee_lastname_m').val();
	parent.previous_string_values[3] = $('#invitee_email').val();
	parent.previous_string_values[4] = $('#invitee_phone_number').val();
	parent.previous_string_values[5] = $('#invitee_address_attributes_street').val();	
	parent.previous_string_values[6] = $('#invitee_address_attributes_number').val();

/* Saving radios failed attempt RLS
	var selected = $("input[checked='checked']");
	$.each(selected,function(i,value){
	parent.previous_id_values[i] = value.attributes[1].nodeValue;
	alert(parent.previous_id_values[i]);
	}); 
*/
 
	

}

function fill_previous_values(){
	
		$('#invitee_name').val(parent.previous_string_values[0]);
		$('#invitee_lastname_p').val(parent.previous_string_values[1]);
		$('#invitee_lastname_m').val(parent.previous_string_values[2]);
		$('#invitee_email').val(parent.previous_string_values[3]);
		$('#invitee_phone_number').val(parent.previous_string_values[4]);
		$('#invitee_address_attributes_street').val(parent.previous_string_values[5]);
		$('#invitee_address_attributes_number').val(parent.previous_string_values[6]);
	
		
	/* Saving radios failed attempt
		$('#invitee_age_id_'+parent.previous_id_values[0]).attr("checked", "checked");
		$('#invitee_gender_id_'+parent.previous_id_values[1]).attr("checked", "checked");
		$('#invitee_status_id_'+parent.previous_id_values[2]).attr("checked", "checked");
		$('#invitee_couple_id_'+parent.previous_id_values[3]).attr("checked", "checked");
		$('#invitee_host_id_'+parent.previous_id_values[4]).attr("checked", "checked");
	*/
}







