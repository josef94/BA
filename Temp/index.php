<html>
  <style>
    a {
         border-style: solid;
         border-width: 1px 1px 1px 1px;
         text-decoration: none;
         padding: 4px;
         border-color: #000000;
         color: black;
         cursor: default;
      }
  </style>

  <?php
    $t=time();
    $temp=file_get_contents('/sys/class/thermal/thermal_zone0/temp');
  ?>

<head>
  <title>Fast and Curious</title>
  <script type="text/javascript"
  src="dygraph.js"></script>
  <link rel="stylesheet" src="dygraph.css" />
</head>
<body>
  <h1>Fast and Curious</h1>
  <img src="http://<?php echo $_SERVER['SERVER_ADDR']; ?>:8080/?action=stream" />
  <br>
  <h3> Video </h3>
  <a href="?run=true">Videoaufnahme starten</a>
  <a href="?stream=true">Stream starten</a>
  <h3> Download </h3>
  <a href="http://<?php echo $_SERVER['SERVER_ADDR']; ?>/Downloads">Zum Download Ordner</a>
  <a href="?crops=true">Crops generieren</a>
  <a href="?feature=true">FeatureVektor generieren</a>
  <a href="?delete=true">Frame Ordner loeschen</a>
  <p> Time:  <b> <?php echo (date("Y-m-d h:i:sa",$t)) ?></b>Uhr </p>
  <p> Temperatur der CPU: <b> <?php echo $temp ?></b> GradC </p>
<body>

  <?php
  $url = $_SERVER["SERVER_ADDR"];
  if ($_GET['run']) {
    exec("/var/www/html/startVideo.sh");
    header("location: index.php");
  }
  if ($_GET['stream']) {
    exec("/var/www/html/startStream.sh");
    sleep(10);
    header("location: index.php");
  }
  if ($_GET['crops']) {
    exec("/var/www/html/generateCrops.sh");
    header("location: index.php");
  }
  if ($_GET['feature']) {
    exec("/var/www/html/generateFeatureVec.sh");
    header("location: index.php");
  }
  if ($_GET['delete']) {
    exec("/var/www/html/deleteFrames.sh");
    header("location: index.php");
  }
?>
</html>

