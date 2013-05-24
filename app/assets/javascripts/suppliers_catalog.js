/* star rating logic */
$(function() {	
	$("ul.supplier_page_rating").each(function(){
		stars = $(this).children(".rating_value").val();
		form_id = "star"
		set_stars(form_id,stars);
	});
});
