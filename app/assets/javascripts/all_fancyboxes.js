$(function(){
	// FGM: Fancybox for youtube tutorial video, not for IE
	if ( !$.browser.msie ) {
		$("#tutorial_video").click(function() {
			$.fancybox({
						'padding'		: 0,
						'autoScale'		: false,
						'transitionIn'	: 'none',
						'transitionOut'	: 'none',
						'title'			: this.title,
						'width'		: 680,
						'height'		: 495,
						'href'			: this.href.replace(new RegExp("watch\\?v=", "i"), 'v/'),
						'type'			: 'swf',
						'swf'			: {
							'wmode'		: 'transparent',
							'allowfullscreen'	: 'true'
						}
					});
			return false;
		});	
	}
		
    $("a.subscription_popup").fancybox({
		'showCloseButton' : false,
		'hideOnOverlayClick': false,
        'hideOnContentClick': false
    });

	$("a#inline").fancybox({
		'hideOnContentClick': true,
		'titleShow': false
	});
	
	$("a#hidden_link").fancybox({
		'hideOnContentClick': false
	}).trigger('click');
	
	$("a#hidden_link_on_overlay").fancybox({
		'hideOnContentClick': false,
		'hideOnOverlayClick': false,
		'showCloseButton': false,
		'enableEscapeButton': false
	});
	
	$("a#budget_hidden_link").fancybox().trigger('click');
	
	// FGM: Images gallery Fancyboxes
	$("a.fancybox").attr('rel','gallery').fancybox();
	
	// fancy_box for supplier calendar
	$("a#form_inline").fancybox({
		'hideOnContentClick': false,
		'onClosed':	function(){ window.location.reload()}
	});
	
	// fancy_box for reviews
	$("a#form_inline_review").fancybox({
		'hideOnContentClick': false,
		'type': 'iframe',
		'width'		: 800,
		'height'		: 440,
		'onClosed':	function(){ window.location.reload()}
	});

	// fancy_box for forms
	$("a#fancybox_form").fancybox();
	
	//fancy_box for messages
	$("a.fancybox_message").fancybox();
	
	// FGM: fancy_box for expenses forms
	$("a.expense_fancybox").fancybox({
		'onComplete': function(){
			filter_supplier_accounts($("a.expense_fancybox").data("type"));
			} 
	});
	
	// FGM: Fancy_box with datepicker for Custom bookings
	$("a.custom_booking_fancybox").fancybox({
		'onComplete': function(){
			$(".datepicker").datepicker({
				onClose: function(dateText, inst) { $(inst.input).change().focusout(); }, 
				autoSize: true, 
				dateFormat: 'dd-M-yy',
				changeMonth: true,
	    	changeYear: true
				});
			validate_custom_booking();
			}
	});
	
	// FGM: Fancy_box for reference requests
	$("a.reference_request_fancybox").fancybox({
		'onComplete': function(){
			validate_custom_booking();
			}
	});
	
	// FGM: Fancy_box for attached notes on booking (reason for some events)
	$("a.attachednote_for_booking_fancybox").fancybox({
		'onComplete': function(){
			validate_attached_message(); // attachednote.js
			}
	});
	
	// fancy_box for forms with dropdowns
	$("a#fancybox_form_with_dropdowns").fancybox({
		'onStart':function(currentArray, currentIndex, currentOpts){
			parent.previous_fancybox = currentIndex;},

		'onComplete': function(){
			filter_regions('invitee_address_attributes'); //invitees.js
			//fill_previous_values();											 //invitees.js
			$("a#fancybox_form_gallery").fancybox({
				'showNavArrows':false,
				'showCloseButton':false,
				'hideOnOverlayClick':false
			});
		},		
		//'onCleanup': function(){store_values();},        //invitees.js
		'showNavArrows':false
	});

	//fancy_box for "editing galleries"
	$("a#fancybox_form_gallery").fancybox({
		'showNavArrows':false,
		'showCloseButton':false,
		'hideOnOverlayClick':false
	});

	$("a.fancybox_before_submit").fancybox({
		'onClosed': function(){ $('form#edit_user_account').submit(); }
	})
});

function reload_fancyboxes(){

	// fancy_box for forms with dropdowns
	$("a#fancybox_form_with_dropdowns").fancybox({
		'onStart':function(currentArray, currentIndex, currentOpts){
			parent.previous_fancybox = currentIndex;},

		'onComplete': function(){
			filter_regions('invitee_address_attributes');
			//fill_previous_values();				
			$("a#fancybox_form_gallery").fancybox({
				'showNavArrows':false,
				'showCloseButton':false,
				'hideOnOverlayClick':false
			});
		},	
		//'onCleanup': function(){store_values();},	
		'showNavArrows':false
	});

	//fancy_box for "editing galleries"
	$("a#fancybox_form_gallery").fancybox({
		'showNavArrows':false,
		'showCloseButton':false,
		'hideOnOverlayClick':false
	});
	
	$("a#fancybox_form").fancybox();
}
