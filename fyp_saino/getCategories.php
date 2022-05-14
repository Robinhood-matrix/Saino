<?php

 include 'DatabaseConfig.php';
 include 'functions.php';
 // Creating MySQL Connection.
 $con = mysqli_connect($HostName,$HostUser,$HostPass,$DatabaseName);
 getCategories('Categories fetched successfully.');
 

