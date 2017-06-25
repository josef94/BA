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
 <head><title>Fast and Curious</title></head>
  <body>
    <h1>Fast and Curious</h1>
    <h3>Bitte richten Sie die Kamera aus und starten Sie die Aufnahme mit dem Button </h3>
    <img src="http://<?php echo $_SERVER['SERVER_ADDR']; ?>:8080/?action=stream" />
    <br>
    <br>
    <a href="?run=true">Videoaufnahme starten</a>
  <body>

  <?php
    if ($_GET['run']) {
      # This code will run if ?run=true is set.
      exec("/var/www/html/switch.sh");
    }
  ?>

</html>
