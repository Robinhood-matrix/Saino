<?php

 include 'DatabaseConfig.php';
 include 'functions.php';
 // Creating MySQL Connection.
 $con = mysqli_connect($HostName,$HostUser,$HostPass,$DatabaseName);
 getProducts("Products fetched successfully.");
 ?>
 