<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
include "../connection.php"; 

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $input_username = $_POST['username'];
    $input_password = $_POST['password'];



    $stmt = $con->prepare("SELECT id, Password FROM `deliveryperson` WHERE UserName=?");
    if (!$stmt) {
        echo json_encode(array("success" => false, "message" => "Database error: failed to prepare statement"));
        exit;
    }

    $stmt->bind_param("s", $input_username);
    if (!$stmt->execute()) {
        echo json_encode(array("success" => false, "message" => "Database error: failed to execute statement"));
        exit;
    }

    $result = $stmt->get_result();
    if ($result->num_rows > 0) {
        $row = $result->fetch_assoc();
        $hashed_password = $row['Password'];
      
        

        if ($input_password === $hashed_password) {  
            echo json_encode(array("success" => true, "user_id" => $row['id']));
        } else {
        
            echo json_encode(array("success" => false, "message" => "Invalid username or password"));
        }
    } else {
      
        echo json_encode(array("success" => false, "message" => "Invalid username or password"));
    }

    $stmt->close();
} else {
    echo json_encode(array("success" => false, "message" => "Invalid request method"));
}

$con->close();

?>
