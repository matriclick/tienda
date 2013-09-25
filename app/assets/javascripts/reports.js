$(function() {
  $("#from").datepicker({ dateFormat: 'yy-mm-dd', firstDay: 1 });
  $("#to").datepicker({ dateFormat: 'yy-mm-dd', firstDay: 1 });
});

function update_amount_to_pay(sa_id, cost, self) {
/*	net_cost = Math.round(dress_price*net_margin/100)
	vat_cost = Math.round(0.19*dress_price*net_margin/100)
	total_cost = dress_price - net_cost - vat_cost
	
	document.getElementById('net_cost').innerHTML = net_cost
	document.getElementById('vat_cost').innerHTML = vat_cost
	document.getElementById('total_cost').innerHTML = total_cost
	$("#dress_net_cost").val(total_cost);*/
	alert(self.val)
	document.getElementById(sa_id).innerHTML = cost;
}