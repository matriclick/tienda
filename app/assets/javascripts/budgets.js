function addSeparator(nStr, separator)
{
    nStr += '';
    x = nStr.split('.');
    x1 = x[0];
    x2 = x.length > 1 ? '.' + x[1] : '';
    var rgx = /(\d+)(\d{3})/;
    while (rgx.test(x1)) {
        x1 = x1.replace(rgx, '$1' + separator + '$2');
    }
    return x1 + x2;
}

function toggle_hideable(extension){
	$('.hideable'+extension).toggle();
	$('.showable'+extension).toggle();
}

function toggle_ic_depending(){
	if ($('input#user_account_budget_distribution_type_id_').is(':checked')) {
		$('.ic_depending').show();
	} else {
		$('.ic_depending').hide();
	}
}

$(function(){
	toggle_ic_depending();
});