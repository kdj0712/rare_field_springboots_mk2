<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css">
    <!-- Google Charts API -->
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <style>
        #map {
          height: 400px;
          width: 100%;
        }
      </style>
</head>

<body>
    <!-- Menu -->
    <%@ include file="/WEB-INF/sample/views/commons/header.jsp" %>

    <!-- Main Content -->

    <div class="container mt-4">
        <div class="row">
            <!-- Bar Chart -->
            <div class="col" id="barChart"></div>

        </div>
        <div class="row">
            <!-- Pie Chart and Line Chart -->
            <div class="col-sm-6" id="pieChart"></div>
            <div class="col-sm-6" id="lineChart"></div>
        </div>

    </div>

    <!-- Footer -->
    <%@ include file="/WEB-INF/sample/views/commons/footer.jsp" %>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js"></script>

    <!-- JavaScript Code -->
    <script type='text/javascript'>
        // Load the Visualization API and the corechart package
        google.charts.load('current', { 'packages': ['corechart'] });

        // Set a callback to run when the Google Visualization API is loaded
        google.charts.setOnLoadCallback(drawCharts);

        // Function to draw the charts
        function drawCharts() {
            // Data for Bar Chart
            // let barData = google.visualization.arrayToDataTable([
            //     ['Category', 'Value'],
            //     ['Category A', 10],
            //     ['Category B', 20],
            //     ['Category C', 15]
            // ]);
            let barData = new google.visualization.arrayToDataTable(${ barDataJson });
            // Error Message in javascript : 실수 데이터 타입 정확히 넘기기
            // Data column(s) for axis #0 cannot be of type string×

            // Options for Bar Chart
            let barOptions = {
                title: 'Bar Chart'
            };

            // Data for Pie Chart
            let pieData = google.visualization.arrayToDataTable([
                ['Fruit', 'Quantity'],
                ['Apple', 30],
                ['Banana', 20],
                ['Orange', 50]
            ]);

            // Options for Pie Chart
            let pieOptions = {
                title: 'Pie Chart'
            };

            // Data for Line Chart
            let lineData = new google.visualization.DataTable();
            lineData.addColumn('number', 'X');
            lineData.addColumn('number', 'Line1');
            lineData.addColumn('number', 'Line2');

            lineData.addRows([
                [1, 5, 7],
                [2, 9, 3],
                [3, 2, 6]
            ]);

            let lineOptions = {
                title: 'Line Chart',
                curveType: 'function',
                legend: { position: 'bottom' }
            };

            let barChart = new google.visualization.BarChart(document.querySelector('#barChart'));
            barChart.draw(barData, barOptions);

            let pieChart = new google.visualization.PieChart(document.querySelector('#pieChart'));
            pieChart.draw(pieData, pieOptions);

            let lineChart = new google.visualization.LineChart(document.querySelector('#lineChart'));
            lineChart.draw(lineData, lineOptions);
        }

    </script>

    <!-- Bootstrap Bundle with Popper.js and Bootstrap JS -->
    <script src='https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js'></script>

</body>

</html>