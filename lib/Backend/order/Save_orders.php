<?php
header('Content-Type: application/json');
include "../connection.php";

function saveOrder($customerId, $productId, $location, $state) {
    global $con;

    $sql = "INSERT INTO `order` (customerId, productId, location, state) 
            VALUES (?, ?, ?, ?)";
    
    $stmt = $con->prepare($sql);    
    $stmt->bind_param("iiss", $customerId, $productId, $location, $state);
    $result = $stmt->execute();

    if ($result) {
        return true;
    } else {
        return false; 
    }
}

$response = array("success" => false, "message" => "Failed to save order");

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Retrieve form data
    $customerId = $_POST['customerId']; 
    $productId = $_POST['productId'];
    // $cartId = $_POST['cartId'];

    $location = $_POST['location'];
    $state = 'pending';

 
    if (saveOrder($customerId, $productId, $location, $state)) {
        $response["success"] = true;
        $response["message"] = "your order has been successfully placed and will be delivered soon!!";
    }
}

echo json_encode($response);
?>
