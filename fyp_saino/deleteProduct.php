<?php
include 'DatabaseConfig.php';
include 'functions.php';
// Creating MySQL Connection.
$con = mysqli_connect($HostName, $HostUser, $HostPass, $DatabaseName);
if (isset($_POST['id'])) {
    $id = $_POST['id'];
    //upload image
   //update is_deleted to 1
    $sql = "UPDATE products SET is_deleted='1' WHERE id='$id'";
    $query = mysqli_query($con, $sql);
    if ($query) {
        getProducts("Product deleted successfully.");
    } else {
        $data = ['success' => false, 'message' => 'Something went wrong.'];
        echo json_encode($data);
    }
} else {
    $data = ['success' => false, 'message' => 'Please Provide id.'];
    echo json_encode($data);
}
