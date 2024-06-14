<?php
include '../../connection.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $name = $_POST['name'];
    $price = $_POST['price'];
    $image = isset($_POST['image']) ? base64_decode($_POST['image']) : null;
     
    
        $sql = "INSERT INTO `product` (name, image, price) VALUES (?, ?, ?)";
        $stmt = $con->prepare($sql);
        $stmt->bind_param('ssi', $name, $image, $price);

        if ($stmt->execute()) {
            echo json_encode(array("success" => true));
        } else {
            echo json_encode(array("success" => false, "error" => $stmt->error));
        }
        

        $stmt->close();
        $con->close();
    } else {
        echo "Failed to upload image.";
    }

?>
