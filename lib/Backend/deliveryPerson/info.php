<?php
include '../connection.php';
if ($_SERVER['REQUEST_METHOD'] === 'POST') {

    if (!isset($_POST['orderId'])) {
        header('Content-Type: application/json');
        echo json_encode(array('error' => 'Order ID is required'));
        exit;
    }

    $orderId = $_POST['orderId'];


    $sql = "SELECT c.FirstName AS FirstName, c.LastName AS LastName, c.UserName AS email,c.image, c.PhoneNumber, o.location,c.Gender
            FROM `order` AS o
            INNER JOIN `customer` AS c ON o.customerId = c.id
            WHERE o.id = ?";

    $stmt = $con->prepare($sql);
    $stmt->bind_param('i', $orderId);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows > 0) {
        $row = $result->fetch_assoc();
        $customerInfo = array(
            'FirstName' => $row['FirstName'],
            'LastName' => $row['LastName'],
            'email' => $row['email'],
            'PhoneNumber' => $row['PhoneNumber'],
            'address' => $row['location'],
            'image' => base64_encode($row['image']),
            'Gender' => $row['Gender']

        );

        header('Content-Type: application/json');
        echo json_encode($customerInfo);
    } else {
        header('Content-Type: application/json');
        echo json_encode(array('error' => 'No customer found for the provided order ID'));
    }


    $stmt->close();
    $con->close();
} else {

    header('Content-Type: application/json');
    echo json_encode(array('error' => 'Unsupported request method'));
}

?>
