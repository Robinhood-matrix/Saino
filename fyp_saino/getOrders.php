<?php
//get orders
include 'DatabaseConfig.php';
$con = mysqli_connect($HostName,$HostUser,$HostPass,$DatabaseName);
$sql = "SELECT *,orders.address as address, orders.id as orderid FROM orders join users on orders.uid=users.id";
$query = mysqli_query($con, $sql);
if ($query) {
    $resultset = array();
    //after the query is sucessfully executed!
    while($row=mysqli_fetch_assoc($query)) {
        $resultset[] = array(
            "id" => $row['orderid'],
            "name" => $row['name'],
            "email" => $row['username'],
            "address" => $row['address'],
            "user_id" => $row['uid'],
            "total" => $row['amount'],
            "payment_method" => $row['method'],
            "delivery_status" => $row['deliverstatus'],
            "transaction_token" => $row['transaction_token'],
            "products" => getProductsWithOrder($row['orderid'])
        );
    }
    $data=[
        'success'=>true,
        'message'=>'Data successfully feteched.',
        'data'=>$resultset

    ];
    echo json_encode($data);
   
} else {

    $data=[
        'success'=>false,
        'message'=>'Something went wrong.'
    ];
    echo json_encode($data);
}

function getProductsWithOrder($id){
    global $con;

    $sql = "SELECT * FROM order_items join products on order_items.proid=products.id where order_items.order_id=$id";
    $query = mysqli_query($con, $sql);
    if ($query) {
        //after the query is sucessfully executed!
        while($row=mysqli_fetch_assoc($query)) {
            $resultset[] = array(
                "id" => $row['id'],
                "name" => $row['name'],
                "price" => $row['price'],
                "quantity" => $row['quantity'],
                "image" => $row['image'],
                "total" => $row['quantity'] * $row['price']
            );
        }
        if(!empty($resultset)){
            return $resultset;
        }
       
    } else {
        return [];
    }

    
}

?>