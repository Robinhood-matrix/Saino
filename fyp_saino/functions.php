<?php
function getCategories($message)
{
    global $con;
    $sql = "SELECT * FROM categories";
    $query = mysqli_query($con, $sql);

    if ($query) {
        $category = array();
        while ($row = mysqli_fetch_assoc($query)) {
            $category[] = $row;
        }
        $data=['success'=>true, 'message'=>$message, 'categories'=>$category];
        echo json_encode($data);
      
    } else {

        $data=[
            'success'=>false,
            'message'=>'Something went wrong.'
        ];
        echo json_encode($data);
    }
}
function getProducts($message)
{
    global $con;
    $sql = "SELECT * FROM products where is_deleted=0";
    $query = mysqli_query($con, $sql);

    if ($query) {
        $products = array();
        while ($row = mysqli_fetch_assoc($query)) {
            $products[] = $row;
        }
        $data=['success'=>true, 'message'=>$message, 'products'=>$products];
        echo json_encode($data);
      
    } else {

        $data=[
            'success'=>false,
            'message'=>'Something went wrong.'
        ];
        echo json_encode($data);
    }
}
?>