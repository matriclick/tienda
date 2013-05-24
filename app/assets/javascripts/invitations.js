function text_alive(id_input,id_write) {  	
	if($('#'+id_input).length>0){
		
		$('#'+id_input).ready(
			function() {			
				$('#'+id_write).html($('#'+id_input).val().replace(new RegExp("$","gm"), '<br/>'));												
			}); 	

		$('#'+id_input).bind("keyup keydown",
			function() {			
				$('#'+id_write).html($('#'+id_input).val().replace(new RegExp("$","gm"), '<br/>'));												
			}); 
		}
}


function fill_invitation_text(upper_left,upper_right,mid_1,mid_2,lower){
	$('#live_upper_left').ready(function(){$('#live_upper_left').val(upper_left);});
	$('#live_upper_right').ready(function(){$('#live_upper_right').val(upper_right);});
	$('#live_mid_1').ready(function(){$('#live_mid_1').val(mid_1);});
	$('#live_mid_2').ready(function(){$('#live_mid_2').val(mid_2);});
	$('#live_lower').ready(function(){$('#live_lower').val(lower);});
}


$(function(){
	text_alive('live_upper_left','upper_left');
	text_alive('live_upper_right','upper_right');
	text_alive('live_mid_1','mid_1');
	text_alive('live_mid_2','mid_2');
	text_alive('live_lower','lower_invitation_text');
});


