<?php
 include 'DatabaseConfig.php';
 include 'functions.php';

    // Creating MySQL Connection.
    $con = mysqli_connect($HostName,$HostUser,$HostPass,$DatabaseName);
    if (isset($_POST['category'])) {
        $category=$_POST['category'];
        //inserting data into database
        $sql = "INSERT INTO categories (category) VALUES ('$category')";
        $query = mysqli_query($con, $sql);
        if ($query) {
            //get categories
            getCategories('Category added successfully.');

        } else {
            $data=['success'=>false, 'message'=>'Something went wrong.'];
            echo json_encode($data);
        }

    }else{
        $data=['success'=>false, 'message'=>'Category is required.'];
        echo json_encode($data);
    }
 ?>