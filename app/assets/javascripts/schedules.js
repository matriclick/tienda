$("#schedule_days_form").ready(function(){ 

var id_check_0 = 'schedule_schedule_days_attributes_0_enabled';
var id_all_day_0 = 'schedule_schedule_days_attributes_0_all_day';
var div_form_0 = '0from';
var div_to_0 = '0to';
var div_start_lunch_time_0 = '0start_lunch_time';
var div_end_lunch_time_0 = '0end_lunch_time';

var id_check_1 = 'schedule_schedule_days_attributes_1_enabled';
var id_all_day_1 = 'schedule_schedule_days_attributes_1_all_day';
var div_form_1 = '1from';
var div_to_1 = '1to';
var div_start_lunch_time_1 = '1start_lunch_time';
var div_end_lunch_time_1 = '1end_lunch_time';

var id_check_2 = 'schedule_schedule_days_attributes_2_enabled';
var id_all_day_2 = 'schedule_schedule_days_attributes_2_all_day';
var div_form_2 = '2from';
var div_to_2 = '2to';
var div_start_lunch_time_2 = '2start_lunch_time';
var div_end_lunch_time_2= '2end_lunch_time';

var id_check_3 = 'schedule_schedule_days_attributes_3_enabled';
var id_all_day_3 = 'schedule_schedule_days_attributes_3_all_day';
var div_form_3 = '3from';
var div_to_3 = '3to';
var div_start_lunch_time_3 = '3start_lunch_time';
var div_end_lunch_time_3 = '3end_lunch_time';

var id_check_4 = 'schedule_schedule_days_attributes_4_enabled';
var id_all_day_4 = 'schedule_schedule_days_attributes_4_all_day';
var div_form_4 = '4from';
var div_to_4 = '4to';
var div_start_lunch_time_4 = '4start_lunch_time';
var div_end_lunch_time_4 = '4end_lunch_time';

var id_check_5 = 'schedule_schedule_days_attributes_5_enabled';
var id_all_day_5 = 'schedule_schedule_days_attributes_5_all_day';
var div_form_5 = '5from';
var div_to_5 = '5to';
var div_start_lunch_time_5 = '5start_lunch_time';
var div_end_lunch_time_5 = '5end_lunch_time';

var id_check_6 = 'schedule_schedule_days_attributes_6_enabled';
var id_all_day_6 = 'schedule_schedule_days_attributes_6_all_day';
var div_form_6 = '6from';
var div_to_6 = '6to';
var div_start_lunch_time_6 = '6start_lunch_time';
var div_end_lunch_time_6 = '6end_lunch_time';


check_event_hour(0);

if ($('#'+id_check_0).is(":checked")){
		if  ($('#'+id_all_day_0).is(":checked"))  {
			block_hours(0);
		} else {			
			unblock_hours(0);
		}
	} else {
		hide_hours(div_form_0, div_to_0, div_start_lunch_time_0, div_end_lunch_time_0);
	}
	
	$('#'+id_check_0).click(function(){
		if ($('#'+id_check_0).is(":checked")) {
			show_hours(div_form_0, div_to_0, div_start_lunch_time_0, div_end_lunch_time_0);
			if  ($('#'+id_all_day_0).is(":checked")) {
				block_hours(0);
			} else {
			 unblock_hours(0);
			}
		} else {
			hide_hours(div_form_0, div_to_0, div_start_lunch_time_0, div_end_lunch_time_0);	
		}
	});
	$('#'+id_all_day_0).click(function(){
		if ($('#'+id_all_day_0).is(":checked")){
			block_hours(0);
		} else{
			unblock_hours(0);
		}
	});	
//day 2
if ($('#'+id_check_1).is(":checked")){
		if  ($('#'+id_all_day_1).is(":checked"))  {
			block_hours(1);
		} else {
			unblock_hours(1);
		}
	} else {
		hide_hours(div_form_1, div_to_1, div_start_lunch_time_1, div_end_lunch_time_1);
	}
	
	$('#'+id_check_1).click(function(){
		if ($('#'+id_check_1).is(":checked")) {
			show_hours(div_form_1, div_to_1, div_start_lunch_time_1, div_end_lunch_time_1);
			if  ($('#'+id_all_day_1).is(":checked")) {
				block_hours(1);
			} else {
			 unblock_hours(1);
			}
		} else {
			hide_hours(div_form_1, div_to_1, div_start_lunch_time_1, div_end_lunch_time_1);	
		}
	});
	$('#'+id_all_day_1).click(function(){
		if ($('#'+id_all_day_1).is(":checked")){
			block_hours(1);
		} else{
			unblock_hours(1);
		}
	});	
//day 3

if ($('#'+id_check_2).is(":checked")){
		if  ($('#'+id_all_day_2).is(":checked"))  {
			block_hours(2);
		} else {
			unblock_hours(2);
		}
	} else {
		hide_hours(div_form_2, div_to_2, div_start_lunch_time_2, div_end_lunch_time_2);
	}
	
	$('#'+id_check_2).click(function(){
		if ($('#'+id_check_2).is(":checked")) {
			show_hours(div_form_2, div_to_2, div_start_lunch_time_2, div_end_lunch_time_2);
			if  ($('#'+id_all_day_2).is(":checked")) {
				block_hours(2);
			} else {
			 unblock_hours(2);
			}
		} else {
			hide_hours(div_form_2, div_to_2, div_start_lunch_time_2, div_end_lunch_time_2);	
		}
	});
	$('#'+id_all_day_2).click(function(){
		if ($('#'+id_all_day_2).is(":checked")){
			block_hours(2);
		} else{
			unblock_hours(2);
		}
	});	

//day 4
if ($('#'+id_check_3).is(":checked")){
		if  ($('#'+id_all_day_3).is(":checked"))  {
			block_hours(3);
		} else {
			unblock_hours(3);
		}
	} else {
		hide_hours(div_form_3, div_to_3, div_start_lunch_time_3, div_end_lunch_time_3);
	}
	
	$('#'+id_check_3).click(function(){
		if ($('#'+id_check_3).is(":checked")) {
			show_hours(div_form_3, div_to_3, div_start_lunch_time_3, div_end_lunch_time_3);
			if  ($('#'+id_all_day_3).is(":checked")) {
				block_hours(3);
			} else {
			 unblock_hours(3);
			}
		} else {
			hide_hours(div_form_3, div_to_3, div_start_lunch_time_3, div_end_lunch_time_3);	
		}
	});
	$('#'+id_all_day_3).click(function(){
		if ($('#'+id_all_day_3).is(":checked")){
			block_hours(3);
		} else{
			unblock_hours(3);
		}
	});	

//day 5
if ($('#'+id_check_4).is(":checked")){
		if  ($('#'+id_all_day_4).is(":checked"))  {
			block_hours(4);
		} else {
			unblock_hours(4);
		}
	} else {
		hide_hours(div_form_4, div_to_4, div_start_lunch_time_4, div_end_lunch_time_4);	
	}
	
	$('#'+id_check_4).click(function(){
		if ($('#'+id_check_4).is(":checked")) {
			show_hours(div_form_4, div_to_4, div_start_lunch_time_4, div_end_lunch_time_4);
			if  ($('#'+id_all_day_4).is(":checked")) {
				block_hours(4);
			} else {
			 unblock_hours(4);
			}
		} else {
			hide_hours(div_form_4, div_to_4, div_start_lunch_time_4, div_end_lunch_time_4);	
		}
	});
	$('#'+id_all_day_4).click(function(){
		if ($('#'+id_all_day_4).is(":checked")){
			block_hours(4);
		} else{
			unblock_hours(4);
		}
	});	

//day 6
if ($('#'+id_check_5).is(":checked")){
		if  ($('#'+id_all_day_5).is(":checked"))  {
			block_hours(5);
		} else {
			unblock_hours(5);
		}
	} else {
		hide_hours(div_form_5, div_to_5, div_start_lunch_time_5, div_end_lunch_time_5);
	}
	
	$('#'+id_check_5).click(function(){
		if ($('#'+id_check_5).is(":checked")) {
			show_hours(div_form_5, div_to_5, div_start_lunch_time_5, div_end_lunch_time_5);
			if  ($('#'+id_all_day_5).is(":checked")) {
				block_hours(5);
			} else {
			 unblock_hours(5);
			}
		} else {
			hide_hours(div_form_5, div_to_5, div_start_lunch_time_5, div_end_lunch_time_5);	
		}
	});
	$('#'+id_all_day_5).click(function(){
		if ($('#'+id_all_day_5).is(":checked")){
			block_hours(5);
		} else{
			unblock_hours(5);
		}
	});	

//day 7
if ($('#'+id_check_6).is(":checked")){
		if  ($('#'+id_all_day_6).is(":checked"))  {
			block_hours(6);
		} else {
			unblock_hours(6);
		}
	} else {
		hide_hours(div_form_6, div_to_6, div_start_lunch_time_6, div_end_lunch_time_6);
	}
	
	$('#'+id_check_6).click(function(){
		if ($('#'+id_check_6).is(":checked")) {
			show_hours(div_form_6, div_to_6, div_start_lunch_time_6, div_end_lunch_time_6);
			if  ($('#'+id_all_day_6).is(":checked")) {
				block_hours(6);
			} else {
			 unblock_hours(6);
			}
		} else {
			hide_hours(div_form_6, div_to_6, div_start_lunch_time_6, div_end_lunch_time_6);	
		}
	});
	$('#'+id_all_day_6).click(function(){
		if ($('#'+id_all_day_6).is(":checked")){
			block_hours(6);
		} else{
			unblock_hours(6);
		}
	});		
}); //this ends the .readyfunction

/* functions to use  */

function block_hours(id_day){
	$('#schedule_schedule_days_attributes_'+id_day+'_from_4i').attr('disabled', true);
	$('#schedule_schedule_days_attributes_'+id_day+'_from_5i').attr('disabled', true);
	$('#schedule_schedule_days_attributes_'+id_day+'_to_4i').attr('disabled', true);		
	$('#schedule_schedule_days_attributes_'+id_day+'_to_5i').attr('disabled', true);
	//luch hours
	$('#schedule_schedule_days_attributes_'+id_day+'_start_lunch_time_4i').attr('disabled', true);
	$('#schedule_schedule_days_attributes_'+id_day+'_start_lunch_time_5i').attr('disabled', true);
	$('#schedule_schedule_days_attributes_'+id_day+'_end_lunch_time_4i').attr('disabled', true);
	$('#schedule_schedule_days_attributes_'+id_day+'_end_lunch_time_5i').attr('disabled', true);
}
function unblock_hours(id_day){
	$('#schedule_schedule_days_attributes_'+id_day+'_from_4i').attr('disabled', false);
	$('#schedule_schedule_days_attributes_'+id_day+'_from_5i').attr('disabled', false);
	$('#schedule_schedule_days_attributes_'+id_day+'_to_4i').attr('disabled', false);		
	$('#schedule_schedule_days_attributes_'+id_day+'_to_5i').attr('disabled', false);
	//luch hours
	$('#schedule_schedule_days_attributes_'+id_day+'_start_lunch_time_4i').attr('disabled', false);
	$('#schedule_schedule_days_attributes_'+id_day+'_start_lunch_time_5i').attr('disabled', false);
	$('#schedule_schedule_days_attributes_'+id_day+'_end_lunch_time_4i').attr('disabled', false);
	$('#schedule_schedule_days_attributes_'+id_day+'_end_lunch_time_5i').attr('disabled', false);
}

function show_hours(div_from, div_to, div_start_lunch_time, div_end_lunch_time){
	$('#'+div_from).show();
	$('#'+div_to).show();
	$('#'+div_start_lunch_time).show();
	$('#'+div_end_lunch_time).show();
}
function hide_hours(div_from, div_to, div_start_lunch_time, div_end_lunch_time){
	$('#'+div_from).hide();
	$('#'+div_to).hide();
	$('#'+div_start_lunch_time).hide();
	$('#'+div_end_lunch_time).hide();
}

function check_schedule_hour(nombre_hora){
	var id_day = nombre_hora.toString().charAt(35);
	if ( $('#schedule_schedule_days_attributes_'+id_day+'_from_4i').val() >= $('#schedule_schedule_days_attributes_'+id_day+'_to_4i').val() && $('#schedule_schedule_days_attributes_'+id_day+'_to_4i').val().length > 0 ) {
		var number = parseInt( $('#schedule_schedule_days_attributes_'+id_day+'_from_4i').val() )+ 1;
		if (number.toString().length == 1){
			if ( parseInt($('#schedule_schedule_days_attributes_'+id_day+'_from_4i').val()) != 0) {
				$('#schedule_schedule_days_attributes_'+id_day+'_to_4i').val("0"+number.toString());
			} else{
				$('#schedule_schedule_days_attributes_'+id_day+'_to_4i').val(number.toString()+"0");
			}
		} else {
			$('#schedule_schedule_days_attributes_'+id_day+'_to_4i').val(parseInt( $('#schedule_schedule_days_attributes_'+id_day+'_from_4i').val() )+ 1);
		}
	}
}

function check_lunch_hour(nombre_hora){
//schedule_schedule_days_attributes_6_start_lunch_time_4i
//schedule_schedule_days_attributes_0_end_lunch_time_4i
	var id_day = nombre_hora.toString().charAt(35);
	if ( $('#schedule_schedule_days_attributes_'+id_day+'_start_lunch_time_4i').val() >= $('#schedule_schedule_days_attributes_'+id_day+'_end_lunch_time_4i').val() && $('#schedule_schedule_days_attributes_'+id_day+'_end_lunch_time_4i').val().length > 0 ) {
		var number = parseInt( $('#schedule_schedule_days_attributes_'+id_day+'_start_lunch_time_4i').val() )+ 1;
		if (number.toString().length == 1){
			if ( parseInt($('#schedule_schedule_days_attributes_'+id_day+'_start_lunch_time_4i').val()) != 0) {
				$('#schedule_schedule_days_attributes_'+id_day+'_end_lunch_time_4i').val("0"+number.toString());
			} else{
				$('#schedule_schedule_days_attributes_'+id_day+'_end_lunch_time_4i').val(number.toString()+"0");
			}
		} else {
			$('#schedule_schedule_days_attributes_'+id_day+'_end_lunch_time_4i').val(parseInt( $('#schedule_schedule_days_attributes_'+id_day+'_start_lunch_time_4i').val() )+ 1);
		}
	}
}

function schedule_type_changed(select_object){ // DZF this submit the form if a schedule_type_day is selected
	if (select_object.value != ""){
		document.forms["edit_schedule"].submit();
	}
}
