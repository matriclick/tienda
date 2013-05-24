$(function(){		
	initialize_stars();
});

function initialize_stars(){
	// FGM: Store stars status
	var stars_statuses = {}
	
	$('li.rate_star').each(function(){ 
		if ($(this).hasClass('rate_star_full')) {
			stars_statuses[$(this).data('star-index')] = "rate_star_full";
		} else if ($(this).hasClass('rate_star_half')) {
			stars_statuses[$(this).data('star-index')] = "rate_star_half";
		};
	});
	
		
	// FGM: Change stars on HOVER
	$('li.rate_star').hover(
		function(){
			if (!($(this).hasClass('disabled'))) {
				var index = $(this).data('star-index');				
				
				for (var i=1; i <= 5; i++) {
					if (i <= index) {
						$('li.rate_star[data-star-index='+i+']').addClass('rate_star_hover');	
					} else {
						$('li.rate_star[data-star-index='+i+']').removeClass('rate_star_full');	
						$('li.rate_star[data-star-index='+i+']').removeClass('rate_star_half');	
					};
				};				
			};
		}, 
		function(){ 
			$('li.rate_star').removeClass('rate_star_hover');
			
			// FGM: Restore stars status
			$.each(stars_statuses, function(key, value){
				$("li.rate_star[data-star-index=" + key + "]").addClass(value);
			});
		}
	);
	
	$('li.rate_star').click(function(){
		$('.stars').addClass('disabled');
		$('li.rate_star').addClass('disabled');
		$('.stars').effect("highlight", {color:"#FEE9C5"}, 2000);
		$(this).closest('form').submit();
	});	
};