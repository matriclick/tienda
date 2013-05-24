function check_date(){

	var fromDate = $("#important_date_date").val().toString();
	var toDate = $("#important_date_ends_date").val().toString();

	month_number_from = month_to_int(fromDate.substring(3,6));
	var DateFromValue = new Date(fromDate.substring(7,12), month_number_from, fromDate.substring(0,2));
	month_number_to = month_to_int(toDate.substring(3,6));
	var DateToValue = new Date(fromDate.substring(7,12), month_number_to, fromDate.substring(0,2));
	
	if (DateToValue <= DateFromValue) {
			$("#important_date_ends_date").attr("value", "");
	}

}

function change_date_format(jsdate){
//this change the javascript date format
//Wed Dec 21 2012 00:00:00 GMT-0300 (CLST)
// to datepicker format
//21-Dec-2012
	dpdate = jsdate.toString().substring(8,10)+"-"+jsdate.toString().substring(4,7)+"-"+jsdate.toString().substring(11,15);
	return dpdate
}

function month_to_int(month_name){
	var month_number;
	switch (month_name)
	{
	case 'Jan':
			month_number = 0;
		break;
	case 'Feb':
			month_number = 1;
		break;
	case 'Mar':
			month_number = 2;
		break;
	case 'Apr':
			month_number = 3;
		break;
	case 'May':
			month_number = 4;
		break;
	case 'Jun':
			month_number = 5;
		break;
	case 'Jul':
			month_number = 6;
		break;
	case 'Aug':
			month_number = 7;
		break;
	case 'Sep':
			month_number = 8;
		break;
	case 'Oct':
			month_number = 9;
		break;
	case 'Nov':
			month_number = 10;
		break;
	case 'Dec':
			month_number = 11;
		break;
	default:
			//alert("not a valid month");
	}
	return month_number;
}
