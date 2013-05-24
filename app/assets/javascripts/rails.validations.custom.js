/*
* 2011-09-13 DZF: This javascript is used to validates rut in client side
*/
clientSideValidations.validators.local["rut"] = function(element, options) {
largo = element.val().toString().length;
if ((message = this.presence(element, options)) && options.allow_blank == true) {
	return;
}
if (element.val().search(/\-/) == -1){ // search if there is a - in the rut DZF
	x = validarut(element.val().slice(0,largo-1),element.val().charAt(largo-1) );
} else {
	x = validarut(element.val().slice(0,largo-2),element.val().charAt(largo-1) );
}
if (x == false ){ return options.message}	

	function validarut(ruti,dvi){ //This function return the RUT validation as a boolean DZF
	//setting expretion without docs DZF
		ruti = ruti.replace(/\./g, "");
		var rut = ruti+"-"+dvi;
		if (rut.length<9) return(false)
		i1=rut.indexOf("-");
		dv=rut.substr(i1+1);
		dv=dv.toUpperCase();
		nu=rut.substr(0,i1);
		cnt=0;
		suma=0;
		for (i=nu.length-1; i>=0; i--)
		  {
		    dig=nu.substr(i,1);
				fc=cnt+2;
				suma += parseInt(dig)*fc;
				cnt=(cnt+1) % 6;
		  }
		  dvok=11-(suma%11);
		  if (dvok==11) dvokstr="0";
		  if (dvok==10) dvokstr="K";
		  if ((dvok!=11) && (dvok!=10)) dvokstr=""+dvok;
		  if (dvokstr==dv) return(true);
		  else
			  return(false);
    }
}
/*
* Here is the javascript for email validations DZF
*/

clientSideValidations.validators.local["email"] = function(element, options) {
	if ((message = this.presence(element, options)) && options.allow_blank == true) {
		return;
	}
  if (!/^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i.test(element.val())) {
    return options.message;
  }
}

clientSideValidations.validators.local["phone_number"] = function(element, options) {
	if ((message = this.presence(element, options)) && options.allow_blank == true) {
		return;
	}
  if (!/[+]?[\d|\s]+$/i.test(element.val())) {
    return options.message;
  }
}
