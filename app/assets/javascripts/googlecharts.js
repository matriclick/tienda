
//google.setOnLoadCallback(function(){drawChart(graph_data_1)});
//google.load('visualization', '1.0', {'packages':['corechart']});


// Callback that creates and populates a data table, 
// instantiates the pie chart, passes in the data and
// draws it.

function drawChart(graph_data) {

// Create the data table.
var data = new google.visualization.DataTable();
data.addColumn('string', graph_data[0].title);
data.addColumn('number', graph_data[0].var_name);
for(i in graph_data)
{
	if(i!=0){data.addRow([graph_data[i].name,graph_data[i].quantity]);}	
}


// Set chart options
var options = {'title': graph_data[0].title,
               'width':graph_data[0].width,
               'height':graph_data[0].height,
			   			 'backgroundColor':'#F5F5F5',
               'legend':graph_data[0].legend
           };

// Instantiate and draw our chart, passing in some options.
if(graph_data[0].type=='column')
	var chart = new google.visualization.ColumnChart(document.getElementById( graph_data[0].div ));
else if(graph_data[0].type=='pie')
	var chart = new google.visualization.PieChart(document.getElementById( graph_data[0].div ));
else if(graph_data[0].type=='bar')
	var chart = new google.visualization.BarChart(document.getElementById( graph_data[0].div ));
else if(graph_data[0].type=='line')
	var chart = new google.visualization.LineChart(document.getElementById( graph_data[0].div ));
chart.draw(data, options);
}
