/*
# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
*/

var set_stars = function(form_id, stars) {
	for(i=1; i <= 5; i++){
		if(i <= stars){
			$('#' + form_id + '_' + i).addClass("on");
		} else {
			$('#' + form_id + '_' + i).removeClass("on");
		}
	}
}

$(function() {
	$('.rating_star').click(function() {
		var star = $(this);
		var form_id = star.attr("data-form-id");
		var stars = star.attr("data-stars");

		$('#' + form_id + '_stars').val(stars);
		var form_id = $(this).attr('id').substring(0, ($(this).attr('id').indexOf("_")) );
		set_stars(form_id, $('#' + form_id + '_stars').val());
	});
	
	/* setting reviews stars classes */
	$("ul.rating").each(function(){
		stars = $(this).children(".rating_value").val();
		form_id = $(this).children(".rating_value").attr("id")
		set_stars(form_id,stars);
	});
	
	// FGM: Loading after submit
	$('form').submit( function(){
		// DZF: dont show the gif if there are some client_side errors
		if ($(".field_with_errors").length > 0 ){
			return false;
		} else {
			$(this).find(".select_loading").show();
		}
	});
});

function change_this_name(object){
	if ( $(object).text() == "(más)" ){
		$(object).text("(menos)");
	} else {
		$(object).text("(más)");
	}
}

/* When editing a review in administration page */

$(function(){
	$("ul.rating").each(function(){
		stars = $(this).children(".rating_value").val();
		form_id = $(this).children(".rating_value").attr("id").substr(0,$(this).children(".rating_value").attr("id").indexOf("_"));
		set_stars(form_id,stars);
	});
});
