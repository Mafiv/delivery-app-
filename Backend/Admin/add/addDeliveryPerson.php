<?php
include '../../connection.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $firstName = $_POST['firstName'];
    $lastName = $_POST['lastName'];
    $userName = $_POST['userName'];
    $password = $_POST['password'];
    $gender = $_POST['gender'];
    $phoneNumber = $_POST['phoneNumber'];
    $address = $_POST['address'];
    
    $imageData = isset($_POST['image']) ? base64_decode($_POST['image']) : null;

    $sql = "INSERT INTO `deliveryPerson` (FirstName, LastName, UserName, Password, Gender, PhoneNumber, Address, Image) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
    $stmt = $con->prepare($sql);
    $stmt->bind_param('ssssssss', $firstName, $lastName, $userName, $password, $gender, $phoneNumber, $address, $imageData);
   
   
    if ($stmt->execute()) {
        echo json_encode(array("success" => true));
    } else {
        echo json_encode(array("success" => false, "error" => $stmt->error));
    }

    $stmt->close();
    $con->close();
}
?>
