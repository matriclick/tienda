$(function() {
  $("#contract_signature_date").datepicker({ dateFormat: 'yy-mm-dd', firstDay: 1 });
  $("#contract_start_contract_date").datepicker({ dateFormat: 'yy-mm-dd', firstDay: 1 });
  $("#contract_end_contract_date").datepicker({ dateFormat: 'yy-mm-dd', firstDay: 1 });
  $("#contract_discount_start").datepicker({ dateFormat: 'yy-mm-dd', firstDay: 1 });
  $("#contract_discount_end").datepicker({ dateFormat: 'yy-mm-dd', firstDay: 1 });
  $("#contract_invoice_from").datepicker({ dateFormat: 'yy-mm-dd', firstDay: 1 });
  $("#contract_invoice_to").datepicker({ dateFormat: 'yy-mm-dd', firstDay: 1 });
});

function invoice_start(date) {
	if($("#contract_invoice_from").val() == "") {
		$("#contract_invoice_from").val(date);
	}
}

function invoice_end(date) {
	if($("#contract_invoice_to").val() == "") {
		$("#contract_invoice_to").val(date);
	}
}