<?php
include '../connection.php';


header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['customer_id'])) {
    $customer_id = $_POST['customer_id'];
    

    $sql = "DELETE FROM `customer` WHERE id = ?";
    $stmt = $con->prepare($sql);
    
    if ($stmt) {
        $stmt->bind_param("i", $customer_id);
        
        if ($stmt->execute()) {
           
            echo json_encode(array('success' => true, 'message' => 'Customer deleted successfully'));
        } else {
            
            echo json_encode(array('success' => false, 'message' => 'Failed to delete customer'));
        }
        
        $stmt->close();
    } else {
        
        echo json_encode(array('success' => false, 'message' => 'Failed to prepare statement'));
    }
} else {
    // Invalid or missing customer ID
    echo json_encode(array('success' => false, 'message' => 'Invalid or missing customer ID'));
}

$con->close();
?>
