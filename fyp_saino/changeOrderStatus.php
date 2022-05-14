<?php
include 'DatabaseConfig.php';
// Creating MySQL Connection.
$con = mysqli_connect($HostName, $HostUser, $HostPass, $DatabaseName);
if (isset($_POST['id'])) {
    $id = $_POST['id'];
    $sql = "SELECT * FROM orders WHERE id='$id'";
    $query = mysqli_query($con, $sql);
    $row = mysqli_fetch_array($query);
    if ($row['deliverstatus'] == 1) {
        $sql = "UPDATE orders SET deliverstatus='0' WHERE id='$id'";
        $query = mysqli_query($con, $sql);
        if ($query) {
            $data = ['success' => true, 'message' => 'Order status updated to pending.'];
            echo json_encode($data);
        } else {
            $data = ['success' => false, 'message' => 'Something went wrong.'];
            echo json_encode($data);
        }
    } else {
        $sql = "UPDATE orders SET deliverstatus='1' WHERE id='$id'";
        $query = mysqli_query($con, $sql);
        if ($query) {
            $data = ['success' => true, 'message' => 'Order status updated to delivered.'];
            echo json_encode($data);
        } else {
            $data = ['success' => false, 'message' => 'Something went wrong.'];
            echo json_encode($data);
        }
    }
}else{
    $data = ['success' => false, 'message' => 'Order id is required.'];
    echo json_encode($data);
}
