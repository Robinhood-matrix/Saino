<?php
 include 'DatabaseConfig.php';
 // Creating MySQL Connection.
 $con = mysqli_connect($HostName,$HostUser,$HostPass,$DatabaseName);
//get username and password from the form
if (isset($_POST['username']) && isset($_POST['password'])) {

    $username = $_POST['username'];
    $password = $_POST['password'];
    //check if the username and password are correct
    $sql = "SELECT * FROM admins where username = '$username'";
    $result = $con->query($sql);
    $errors=[];
    
    if ($result->num_rows > 0) {
        while ($row[] = $result->fetch_assoc()) {

            $tem = $row;
        }
        $dbPWD = $tem[0]['password'];
        if ($password==$dbPWD) {
            $userid = $tem[0]['id'];
            $user = [
                'id' => $userid,
                'username' => $tem[0]['username'],
            ];
            $response = [
                'success' => true,
                'user' => $user
            ];

            echo json_encode($response);
        } else {
            
            $errors["password"] = 'Password you entered was incorrect.';
            $data = ['success' => false, 'message' => $errors];
            echo json_encode($data);
        }
    } else {
        $errors["email"] = 'The user is not registered.';
        //if the username and password are incorrect
        //go to the login page
        $response = [
            'success' => false,
            'message' => $errors
        ];
        echo json_encode($response);
    }
} else {
    $errors["email"] = 'The user is not registered.';
    //if the username and password weren't set
    //go to the login page
    $response = [
        'success' => false,
        'message' => $errors
    ];
    echo json_encode($response);
}
