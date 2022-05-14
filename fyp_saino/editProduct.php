<?php
include 'DatabaseConfig.php';
include 'functions.php';
// Creating MySQL Connection.
$con = mysqli_connect($HostName, $HostUser, $HostPass, $DatabaseName);
if (
    isset($_POST['name']) &&
    isset($_POST['id']) &&
    isset($_POST['categoryId']) &&
    isset($_POST['description']) &&
    isset($_FILES['image']) &&
    isset($_POST['price'])
) {
    $id = $_POST['id'];
    $name = $_POST['name'];
    $categoryId = $_POST['categoryId'];
    $description = $_POST['description'];
    $price = $_POST['price'];
    //getimage
    $image = $_FILES['image']['name'];
    $image_tmp = $_FILES['image']['tmp_name'];
    $image_size = $_FILES['image']['size'];
    $image_ext = pathinfo($image, PATHINFO_EXTENSION);
    $image_path = "images/" . $image;

    //upload image
    if ($image_size < 5000000) {
        if ($image_ext == "jpg" || $image_ext == "png" || $image_ext == "jpeg") {
            if (move_uploaded_file($image_tmp, $image_path)) {
                //inserting data into database
                $sql = "UPDATE products SET name='$name', category_id='$categoryId', description='$description', price='$price', image='$image_path' WHERE id='$id'";
                $query = mysqli_query($con, $sql);
                if ($query) {
                    getProducts("Product updated successfully.");
                } else {
                    $data = ['success' => false, 'message' => 'Something went wrong.'];
                    echo json_encode($data);
                }
            } else {
                $data = ['success' => false, 'message' => 'Something went wrong.'];
                echo json_encode($data);
            }
        } else {
            $data = ['success' => false, 'message' => 'Image must be jpg, png or jpeg.'];
            echo json_encode($data);
        }
    } else {
        $data = ['success' => false, 'message' => 'Image size must be less than 5MB.'];
        echo json_encode($data);
    }
} else {
    $data = ['success' => false, 'message' => 'Name,price, image, and parent id is required.'];
    echo json_encode($data);
}
