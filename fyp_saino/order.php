<?php
 include 'DatabaseConfig.php';
 $con = mysqli_connect($HostName,$HostUser,$HostPass,$DatabaseName);
 if( isset($_POST['order_items']) &&
  isset($_POST['method']) &&
    isset($_POST['transaction_token']) &&
    isset($_POST['user_id']) &&
    isset($_POST['address']) &&
    isset($_POST['amount'])) //check is details sent by the user
 {
    $order_items =json_decode($_POST['order_items']);
    $transaction_token = $_POST['transaction_token'];
    $order_method = $_POST['method'];
    $user_id = $_POST['user_id'];
    $amount = $_POST['amount'];
    $address = $_POST['address'];
    
    createOrder($user_id,$amount);

 }else{
    $data=['success'=>false, 'message'=>'Unable to process the request due to incomplete details.'];
    
    echo json_encode($data);
 }

 function insertOrderItem($proid,$item, $order_id){
    $qty = $item->quantity;
    global $con;
    $insert = "INSERT INTO order_items (proid,quantity,order_id)VALUES('$proid','$qty','$order_id')";
    mysqli_query($con, $insert);
 }
 function makeANewOrder($uid,$amount, $method, $deliverstatus,$transaction_token){

    global $con;
    global $address;
    $insert = "INSERT INTO orders (uid,amount,method,deliverstatus,transaction_token,address)VALUES('$uid','$amount','$method','$deliverstatus','$transaction_token','$address')";
    return mysqli_query($con, $insert);
 }

 function createOrder($uid,$amount){
    global $order_items;
    global $order_method;
    global $transaction_token;
    global $con;

    switch ($order_method) {
        case '1':
            $qurey=makeANewOrder($uid,$amount, $order_method, '0',$transaction_token);
            if($qurey){
                $order_id = $con->insert_id;
               $order_items = json_decode($_POST['order_items']);
                foreach ($order_items as $key => $value) {
                    insertOrderItem($key,json_decode($value) , $order_id);
                }
                $data=['success'=>true, 'message'=>'Order Succesfully Submitted.'];
                echo json_encode($data);
            }else{
                $data=['success'=>false, 'message'=>'Something went wrong.'];
                echo json_encode($data);
            }
            break;
        case '2':
         $qurey=makeANewOrder($uid,$amount, $order_method, '0',$transaction_token);
            if($qurey){
                $order_id = $con->insert_id;
               $order_items = json_decode($_POST['order_items']);
                foreach ($order_items as $key => $value) {
                    insertOrderItem($key,json_decode($value) , $order_id);
                }
                $data=['success'=>true, 'message'=>'Order Succesfully Submitted.'];
                echo json_encode($data);
            }else{
                $data=['success'=>false, 'message'=>'Something went wrong.'];
                echo json_encode($data);
            }
            break;
        case '3':
            $qurey=makeANewOrder($uid,$amount, $order_method, '0',$transaction_token);
            if($qurey){
                $order_id = $con->insert_id;
                foreach ($order_items as $key => $value) {
                    insertOrderItem($key,$value->orderQuantity, $order_id);
                }
                $data=['success'=>true, 'message'=>'Order Succesfully Submitted.'];
                echo json_encode($data);
            }else{
                $data=['success'=>false, 'message'=>'Something went wrong.'];
                echo json_encode($data);
            }
        default:
            $data=['success'=>false, 'message'=>'Unkown order method'];
            echo json_encode($data);
          
      }
}
