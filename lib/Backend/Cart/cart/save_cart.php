<?php
include "../connection.php";

if ($_SERVER["REQUEST_METHOD"] == "POST") {


$customerId = $_POST['customerId'];
$productId = $_POST['productId'];


$stmt = $con->prepare("INSERT INTO `cart` (customerId, productId) VALUES (?, ?)");
$stmt->bind_param("ii", $customerId, $productId);


if ($stmt->execute()) {
    echo json_encode(["success" => true, "message" => "New record created successfully"]);
} else {
    echo json_encode(["success" => false, "message" => $stmt->error]);
}

$stmt->close();
$con->close();
}
?>
