<html>
<head>
<script type="text/javascript"
  src="dygraph.js"></script>
<link rel="stylesheet" src="dygraph.css" />
</head>
<body>
<div id="graphdiv3"
  style="width:800px; height:300px;"></div>
<script type="text/javascript">
  g3 = new Dygraph(
    document.getElementById("graphdiv3"),
    "temperatures.csv",
    {
      rollPeriod: 7,
      showRoller: true
    }
  );
</script>
</body>
</html>
