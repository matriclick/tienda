$(function(){
	$('#average_budget').change(
		function() {
			for(var i=1; i<=4; i++){$('#average_chart_'+i).hide();}
			$('#average_chart_'+$('#average_budget :selected').val()).show();
		});
	});
