<?php
include "../connection.php"; 

if ($_SERVER["REQUEST_METHOD"] == "POST") {

    $itemId = $_POST['cart_id'];

    $sql = "DELETE FROM cart WHERE id = ?";
    
    $stmt = $con->prepare($sql);

    $stmt->bind_param("i", $itemId);

    if ($stmt->execute()) {

        echo json_encode(array("success" => true));
    } else {

        echo json_encode(array("success" => false, "error" => $stmt->error));
    }

 
    $stmt->close();
}

?>
