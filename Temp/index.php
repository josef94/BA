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

<head><title>Fast and Curious</title></head>
  <body>
    <h1>Fast and Curious</h1>
    <br>
    <img src="http://<?php echo $_SERVER['SERVER_ADDR']; ?>:8080/?action=stream" />
    <br>
    <br>
    <a href="?run=true">Videoaufnahme starten</a>
    <a href="?stream=true">Stream starten</a>
    <a href="http://<?php echo $_SERVER['SERVER_ADDR']; ?>/Downloads"> Go to Download Folder</a>
    <a href="?crops=true">Crops generieren</a>
    <a href="?feature=true">FeatureVektor generieren</a>

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
  ?>

</html>
