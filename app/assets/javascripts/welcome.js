$(function() {
  if ($('#charts').length > 0) {
        $.getJSON(location.pathname+'.json', function(data) {
        _.each(data, function(obj, date) {
        var $row = $('<div/>', {class:'row'});
        $row.append()
        $('#charts').append($('<div/>', {
          id: date + '-amount', class:'col-md-6'
        }));
        $row.append($('<div/>', {
            id: date + '-count', class: 'col-md-6'
        }));
        $('#charts').append($row);
        var amountSeries = _.map(obj.types, function(value, key) {
            return {
                name: key,
                data:[value.amount]
            };
        });

        var countSeries = _.map(obj.types, function(value, key) {
            return {
                name: key,
                data:[value.count]
            };
        });
        debugger;
        // Chart with count
        new Highcharts.Chart({
        chart: {
          renderTo: date + '-amount',
          type: 'column',
          margin: 75,
          options3d: {
            enabled: true,
            alpha: 15,
            beta: 15,
            depth: 50,
            viewDistance: 25
          }
        },
        tooltip: {
            yDecimals:2,
            pointFormat: "{point.y:.2f}"
            //formatter: function() {
            //    return this.series.name + ': {point.y:.2f}';
            //}
        },
        title: {
          text: date + ' Amounts Per Category'
        },
        plotOptions: {
          column: {
            depth: 25
          }
        },
        series: amountSeries
      });

    // Chart with amounts
        new Highcharts.Chart({
            chart: {
                renderTo: date + '-count',
                type: 'column',
                margin: 75,
                options3d: {
                    enabled: true,
                    alpha: 15,
                    beta: 15,
                    depth: 50,
                    viewDistance: 25
                }
            },
            title: {
                text: date + ' Counts Per Category'
            },
            tooltip: {
                formatter: function() {
                    return this.series.name + ': ' + this.y;
                }
            },
            plotOptions: {
                column: {
                    depth: 25
                }
            },
            series: countSeries
        });


    });
    });
    }
});