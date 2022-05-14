<?php

 include 'DatabaseConfig.php';
 // Creating MySQL Connection.
 $con = mysqli_connect($HostName,$HostUser,$HostPass,$DatabaseName);
 
 if( isset($_POST['email']) && 
 isset($_POST['name']) &&
 isset($_POST['address']) &&
 isset($_POST['phone']) &&
  isset($_POST['password'])) //check is token is sent by the user
    {
    $email = $_POST['email'];
    $name = $_POST['name'];
    $address = $_POST['address'];
    $phone = $_POST['phone'];
 
    // Getting Password from JSON $obj array and store into $password.
    $password = $_POST['password'];
    $error='';
    if(emailChecker($email)){
        $error="Email is already registered";
    }
    if((!emailChecker($email))){
        trySignup();
    }else{
        $data=[
            'email'=>$email,
            'success'=>false,
            'message'=>$error
        ];
        echo json_encode($data);
    }
    //Applying User Login query with email and password.
 
    }else{
    $data=['success'=>false, 'message'=>'Please fill all the fields.'];

    echo json_encode($data);
}
function emailChecker($email)
{
    global $con;
    $userQuery = "SELECT * FROM users WHERE username ='$email'";
    $sendingQuery = mysqli_query($con, $userQuery);
    $checkQuery = mysqli_num_rows($sendingQuery);

    if ($checkQuery > 0) {
        // if Username is already registered
       return true;
    } else {
        return false;
    }
}


function trySignup()
{
    global $con;
    global $email;
    global $name;
    global $password;
    global $address;
    global $phone;

    $hashPwd = password_hash($password, PASSWORD_DEFAULT);

    $insert = "INSERT INTO users (username, password, name, address, phone, is_admin) VALUES ('$email', '$hashPwd', '$name', '$address', '$phone', 0)";
    $query = mysqli_query($con, $insert);
    
    if ($query) {
        $user=[
            'id'=>mysqli_insert_id($con),
            'username'=>$email,
            'name'=>$name,
            'address'=>$address,
            'phone'=>$phone,
            'is_admin'=>'0',
        ];
        //after the query is sucessfully executed!
        $data=[
            'user'=>$user,
            'success'=>true,
            'message'=>'Signup Successful'
        ];
        echo json_encode($data);

    } else {

        $data=[
            'email'=>$email,
            'success'=>false,
            'message'=>'SignUp Failed.'
        ];
        echo json_encode($data);
    }
}

?>
