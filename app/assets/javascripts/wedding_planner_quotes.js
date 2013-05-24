$(function() {
  $("#wedding_planner_quote_fecha_del_matrimonio").datepicker({ dateFormat: 'yy-mm-dd', firstDay: 1 });
  update_ppto_final()
})

function update_ppto() {
	total = $("#ppto_global").val();
	numbers = parseInt(total.match(/\d+\.?\d*/g))
	
	$("#wedding_planner_quote_presupuesto_banqueteria").val(Math.round(numbers*0.5));
	$("#wedding_planner_quote_presupuesto_centro_de_eventos").val(Math.round(numbers*0.2));
	$("#wedding_planner_quote_presupuesto_iglesia").val(Math.round(numbers*0.3/29));
	$("#wedding_planner_quote_presupuesto_civil").val(Math.round(numbers*0.3/29));
	$("#wedding_planner_quote_presupuesto_coro").val(Math.round(numbers*0.3/29));
	$("#wedding_planner_quote_presupuesto_flores").val(Math.round(numbers*0.3/29));
	$("#wedding_planner_quote_presupuesto_arriendo_auto").val(Math.round(numbers*0.3/29));
	$("#wedding_planner_quote_presupuesto_decoracion_salon").val(Math.round(numbers*0.3/29));
	$("#wedding_planner_quote_presupuesto_musica_iluminacion").val(Math.round(numbers*0.3/29));
	$("#wedding_planner_quote_presupuesto_argollas").val(Math.round(numbers*0.3/29));
	$("#wedding_planner_quote_presupuesto_fotografia").val(Math.round(numbers*0.3/29));
	$("#wedding_planner_quote_presupuesto_video").val(Math.round(numbers*0.3/29));
	$("#wedding_planner_quote_presupuesto_animacion").val(Math.round(numbers*0.3/29));
	$("#wedding_planner_quote_presupuesto_cotillon").val(Math.round(numbers*0.3/29));
	$("#wedding_planner_quote_presupuesto_partes_de_matrimonio").val(Math.round(numbers*0.3/29));
	$("#wedding_planner_quote_presupuesto_torta_de_novios").val(Math.round(numbers*0.3/29));
	$("#wedding_planner_quote_presupuesto_recuerdo_matrimonio").val(Math.round(numbers*0.3/29));
	$("#wedding_planner_quote_presupuesto_vinos").val(Math.round(numbers*0.3/29));
	$("#wedding_planner_quote_presupuesto_bar_destilados").val(Math.round(numbers*0.3/29));
	$("#wedding_planner_quote_presupuesto_vestido_novia").val(Math.round(numbers*0.3/29));
	$("#wedding_planner_quote_presupuesto_maquillaje").val(Math.round(numbers*0.3/29));
	$("#wedding_planner_quote_presupuesto_peinado").val(Math.round(numbers*0.3/29));
	$("#wedding_planner_quote_presupuesto_tocado").val(Math.round(numbers*0.3/29));
	$("#wedding_planner_quote_presupuesto_ramo_de_novia").val(Math.round(numbers*0.3/29));
	$("#wedding_planner_quote_presupuesto_zapatos_novia").val(Math.round(numbers*0.3/29));
	$("#wedding_planner_quote_presupuesto_traje_novio").val(Math.round(numbers*0.3/29));
	$("#wedding_planner_quote_presupuesto_camisa_a_medida").val(Math.round(numbers*0.3/29));
	$("#wedding_planner_quote_presupuesto_extras").val(Math.round(numbers*0.3/29));
	$("#wedding_planner_quote_presupuesto_zapatos_novio").val(Math.round(numbers*0.3/29));
	
	update_ppto_final()
}

function update_ppto_final() {
	if(document.getElementById('ppto_global') != null) {
		total =
		parseInt($("#wedding_planner_quote_presupuesto_banqueteria").val())+
		parseInt($("#wedding_planner_quote_presupuesto_centro_de_eventos").val())+
		parseInt($("#wedding_planner_quote_presupuesto_iglesia").val())+
		parseInt($("#wedding_planner_quote_presupuesto_civil").val())+
		parseInt($("#wedding_planner_quote_presupuesto_coro").val())+
		parseInt($("#wedding_planner_quote_presupuesto_flores").val())+
		parseInt($("#wedding_planner_quote_presupuesto_arriendo_auto").val())+
		parseInt($("#wedding_planner_quote_presupuesto_decoracion_salon").val())+
		parseInt($("#wedding_planner_quote_presupuesto_musica_iluminacion").val())+
		parseInt($("#wedding_planner_quote_presupuesto_argollas").val())+
		parseInt($("#wedding_planner_quote_presupuesto_fotografia").val())+
		parseInt($("#wedding_planner_quote_presupuesto_video").val())+
		parseInt($("#wedding_planner_quote_presupuesto_animacion").val())+
		parseInt($("#wedding_planner_quote_presupuesto_cotillon").val())+
		parseInt($("#wedding_planner_quote_presupuesto_partes_de_matrimonio").val())+
		parseInt($("#wedding_planner_quote_presupuesto_torta_de_novios").val())+
		parseInt($("#wedding_planner_quote_presupuesto_recuerdo_matrimonio").val())+
		parseInt($("#wedding_planner_quote_presupuesto_vinos").val())+
		parseInt($("#wedding_planner_quote_presupuesto_bar_destilados").val())+
		parseInt($("#wedding_planner_quote_presupuesto_vestido_novia").val())+
		parseInt($("#wedding_planner_quote_presupuesto_maquillaje").val())+
		parseInt($("#wedding_planner_quote_presupuesto_peinado").val())+
		parseInt($("#wedding_planner_quote_presupuesto_tocado").val())+
		parseInt($("#wedding_planner_quote_presupuesto_ramo_de_novia").val())+
		parseInt($("#wedding_planner_quote_presupuesto_zapatos_novia").val())+
		parseInt($("#wedding_planner_quote_presupuesto_traje_novio").val())+
		parseInt($("#wedding_planner_quote_presupuesto_camisa_a_medida").val())+
		parseInt($("#wedding_planner_quote_presupuesto_extras").val())+
		parseInt($("#wedding_planner_quote_presupuesto_zapatos_novio").val());
	
		document.getElementById('ppto_total').innerHTML = addCommas(total);
	    $("#ppto_global").val(total);
	}
}

function addCommas(str) {
    var amount = new String(str);
    amount = amount.split("").reverse();

    var output = "";
    for ( var i = 0; i <= amount.length-1; i++ ){
        output = amount[i] + output;
        if ((i+1) % 3 == 0 && (amount.length-1) !== i)output = ',' + output;
    }
    return output;
}