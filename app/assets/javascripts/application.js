// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require init_vendors
//= require rails.validations
//= require_directory .
// ALERT: FETCHING THIS DIRECTORY ONLY, NOT THE HOLE TREE

function remove_fields_post(link) {
  $(link).prev("input[type=hidden]").val("1");
  $(link).closest(".to_hide").hide();
}

function add_fields_post(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g")
  $(link).prev().after(content.replace(regexp, new_id));
}

// Google Map
function initialize(lat, lon, address) {
    var latlng = new google.maps.LatLng(lat, lon);
    var myOptions = {
      zoom: 15,
      center: latlng,
      mapTypeId: google.maps.MapTypeId.ROADMAP
    };
    var map = new google.maps.Map(document.getElementById("map"),
        myOptions);
        
		var marker = new google.maps.Marker({
		      position: latlng,
		      title: address
	  });
  
	// To add the marker to the map, call setMap();
  	marker.setMap(map);  
}

$(function(){
	//Slide para el Menú de Ingreso
	$('.log_in_down').click(function () {
		if ($(".log_in").is(":hidden")) {
			$(".log_in").slideDown("fast");
		} else {
			$(".log_in").slideUp("fast");
		}
	});
	
		// Placeholder fix for non-HTML-5 browsers (applied to every browser at the moment)
		$('[placeholder]').focus(function() {
		  var input = $(this);
		  if (input.val() == input.attr('placeholder')) {
		    input.val('');
		    input.removeClass('placeholder');
		  }
		}).blur(function() {
		  var input = $(this);
		  if (input.val() == '' || input.val() == input.attr('placeholder')) {
		    input.addClass('placeholder');
		    input.val(input.attr('placeholder'));
		  }
		}).blur();
	
		$('[placeholder]').parents('form').submit(function() {
		  $(this).find('[placeholder]').each(function() {
		    var input = $(this);
		    if (input.val() == input.attr('placeholder')) {
		      input.val('');
		    }
		  })
		});
 
	
	// FGM: Flashes fading out...
	$(".slideFadeOut").animate({opacity: 0.6}, 2000).
		animate({opacity: 1}, 2000).
		animate({opacity: 0.6}, 2000).
		animate({opacity: 1}, 2000).
		animate({opacity: 0.6}, 2000).
		animate({opacity: 1}, 2000).
		animate({ height: 0, opacity: 0 }, 'slow');
	
	$(".tiptip").tipTip({
		edgeOffset: 10,
		defaultPosition: "right",
		activation: "click",
		delay:0
		});
		
	$(".hovertip").tipTip({ // appears faster with fadeIn
		edgeOffset: 10,
		defaultPosition: "right",
		activation: "hover",
		delay:0,
		fadeIn:1
		});

	// FGM: Feedback Tab
	$('.slide-out-div').tabSlideOut({
  	tabHandle: '.handle',                     //class of the element that will become your tab
    // pathToTabImage: '/assets/feedback.png', //path to the image for the tab //Optionally can be set using css
    tabLocation: 'top',                      //side of screen where tab lives, top, right, bottom, or left
    speed: 300,                              //speed of animation
    action: 'click',                          //options: 'click' or 'hover', action to trigger animation
    topPos: '75px',                          //position from the top/ use if tabLocation is left or right
    rightPos: '800px',                          //position from left/ use if tabLocation is bottom or top
    fixedPosition: false                      //options: true makes it stick(fixed position) on scroll
  });	
});

$(function(){
	//Slide para selección de país
	$('.country_down').click(function () {
		if ($(".country_tab").is(":hidden")) {
			$(".country_tab").slideDown("fast");
		} else {
			$(".country_tab").slideUp("fast");
		}
	});	
	
		// Placeholder fix for non-HTML-5 browsers (applied to every browser at the moment)
		$('[placeholder]').focus(function() {
		  var input = $(this);
		  if (input.val() == input.attr('placeholder')) {
		    input.val('');
		    input.removeClass('placeholder');
		  }
		}).blur(function() {
		  var input = $(this);
		  if (input.val() == '' || input.val() == input.attr('placeholder')) {
		    input.addClass('placeholder');
		    input.val(input.attr('placeholder'));
		  }
		}).blur();
	
		$('[placeholder]').parents('form').submit(function() {
		  $(this).find('[placeholder]').each(function() {
		    var input = $(this);
		    if (input.val() == input.attr('placeholder')) {
		      input.val('');
		    }
		  })
		});
 
	
	// FGM: Flashes fading out...
	$(".slideFadeOut").animate({opacity: 0.6}, 2000).
		animate({opacity: 1}, 2000).
		animate({opacity: 0.6}, 2000).
		animate({opacity: 1}, 2000).
		animate({opacity: 0.6}, 2000).
		animate({opacity: 1}, 2000).
		animate({ height: 0, opacity: 0 }, 'slow');
	
	$(".tiptip").tipTip({
		edgeOffset: 10,
		defaultPosition: "right",
		activation: "click",
		delay:0
		});
		
	$(".hovertip").tipTip({ // appears faster with fadeIn
		edgeOffset: 10,
		defaultPosition: "right",
		activation: "hover",
		delay:0,
		fadeIn:1
		});

	// FGM: Feedback Tab
	$('.slide-out-div').tabSlideOut({
  	tabHandle: '.handle',                     //class of the element that will become your tab
    // pathToTabImage: '/assets/feedback.png', //path to the image for the tab //Optionally can be set using css
    tabLocation: 'top',                      //side of screen where tab lives, top, right, bottom, or left
    speed: 300,                              //speed of animation
    action: 'click',                          //options: 'click' or 'hover', action to trigger animation
    topPos: '75px',                          //position from the top/ use if tabLocation is left or right
    rightPos: '800px',                          //position from left/ use if tabLocation is bottom or top
    fixedPosition: false                      //options: true makes it stick(fixed position) on scroll
  });	
});

// 2011/09/14 DZF: this function will be used to validate the file_fields in the client side 
function check_file_type(file){
	file = file.value.toString();
	if ( file.search(/jpeg|png|gif|jpg/)== -1 )  {
		//alert ("FALSO");
	}
}


// DZF after the validation this gives a format to the rut value
function format_rut (Rut){
  var x = (parseInt(Rut.value.toString().length-1));
  var digitoVerificador = Rut.value.charAt(x);
  var sRut = new String(Rut.value);
  var sRutFormateado = '';
  sRut = jQuery.Rut.quitarFormato(sRut);
  if(digitoVerificador){
    var sDV = sRut.charAt(sRut.length-1);
    sRut = sRut.substring(0, sRut.length-1);
  }
  while( sRut.length > 3 ){
    sRutFormateado = "." + sRut.substr(sRut.length - 3) + sRutFormateado;
    sRut = sRut.substring(0, sRut.length - 3);
  }
  sRutFormateado = sRut + sRutFormateado;
  if(sRutFormateado != "" && digitoVerificador){
    sRutFormateado += "-"+sDV;
  } else if(digitoVerificador){
    sRutFormateado += sDV;
  }
  Rut.value = sRutFormateado;
}

// add an remove price docs

function addDocs(nStr){
  nStr += '';
  x = nStr.split('.');
  x1 = x[0];
  x2 = x.length > 1 ? '.' + x[1] : '';
  var rgx = /(\d+)(\d{3})/;
  while (rgx.test(x1)) {
      x1 = x1.replace(rgx, '$1' + '.' + '$2');
  }
  return x1 + x2;
}
function removeDocs(nStr){
  nStr = nStr.replace(/\./g, "");
  return nStr;
}

// onlyDigits function

jQuery.fn.onlyDigits = function() {
    var k;
    // little trick just in case you want use this:
    $('<span></span>').insertAfter(this);
    var $dText = $(this).next('span').hide();
    // Really cross-browser key event handler
    function Key(e) {
        if (!e.which && ((e.charCode ||
        e.charCode === 0) ? e.charCode: e.keyCode)) {
        e.which = e.charCode || e.keyCode;
        } return e.which; }
    return $(this).each(function() {
        $(this).keydown(function(e) {
            k = Key(e);
            return (
            // Allow CTRL+V , backspace, tab, delete, arrows,
            // numbers and keypad numbers ONLY
            ( k == 86 && e.ctrlKey ) || (k == 224 && e.metaKey) || k == 8 || k == 9 || k == 46 || (k >= 37 && k <= 40 && k !== 32 ) || (k >= 48 && k <= 57) || (k >= 96 && k <= 105));
        }).keyup(function(e) {
            var value = this.value.replace(/\s+/,'-');
            // Check if pasted content is Number
            if (isNaN(value)) {
                // re-add stored digits if CTRL+V have non digits chars
                $(this).val($dText.text());
            } else { // store digits only of easy access
                $dText.empty().append(value);
            }
        });
    });
};

