<?php
 include 'DatabaseConfig.php';
 include 'functions.php';
    // Creating MySQL Connection.
    $con = mysqli_connect($HostName,$HostUser,$HostPass,$DatabaseName);
    if (isset($_POST['category']) && isset($_POST['id'])) {
        $category=$_POST['category'];
      //update category
        $sql = "UPDATE categories SET category='$category' WHERE id='$_POST[id]'";
        $query = mysqli_query($con, $sql);
        if ($query) {
           getCategories('Category updated successfully.');
        } else {
            $data=['success'=>false, 'message'=>'Something went wrong.'];
            echo json_encode($data);
        }

    }else{
        $data=['success'=>false, 'message'=>'Category and id is required.'];
        echo json_encode($data);
    }
 ?>