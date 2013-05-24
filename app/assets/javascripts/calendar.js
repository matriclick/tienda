$(function(){
	$('span.unavailable_day').closest('td').css('background-color','#ddd');
});

function toggle_description(link){
	parent = $(link).parent();
	parent.children(".hideable").toggle();
	parent.children(".see_less").toggle();
	parent.children(".showable").toggle();
	parent.children(".see_more").toggle();
}
/*
$(function(){
	$('span.important_date_no_blocked_day').closest('td').css('background-color','#acd');
});
*/
