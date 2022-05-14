<?php

 include 'DatabaseConfig.php';
 // Creating MySQL Connection.
 $con = mysqli_connect($HostName,$HostUser,$HostPass,$DatabaseName);
    if( isset($_POST['email']) && isset($_POST['password']) ) 
        {
        $email = $_POST['email'];
        $password = $_POST['password'];

        $sql = "SELECT * FROM users where username = '$email'";
        $result = $con->query($sql);
        
        if ($result->num_rows > 0) {

            while ($row[] = $result->fetch_assoc()) {
                $tem = $row;
            }

            $dbPWD = $tem[0]['password'];

            if (password_verify($password, $dbPWD)) {
                $userid = $tem[0]['id'];
                $user=[
                    'id'=>$userid,
                    'username'=>$tem[0]['username'],
                    'name'=>$tem[0]['name'],
                    'is_admin'=>$tem[0]['is_admin'],
                    'phone'=>$tem[0]['phone'],
                    'address'=>$tem[0]['address'],
                ];
                $response=[
                    'success'=>true,
                    'message'=>'Login Successful',
                    'user'=>$user
                ];
                
                   echo json_encode($response);
            } else {

                $data=['success'=>false, 'message'=>'Password you entered was incorrect.'];
                echo json_encode($data);
            }

        } else {

            $data=['success'=>false, 'message'=>'The user is not registered.'];
            echo json_encode($data);
        }
    }else{
        $data=['success'=>false, 'message'=>'Email and Password are required.'];

        echo json_encode($data);
    }
