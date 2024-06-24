<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);   
error_reporting(E_ALL);

include "../connection.php";

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $customerId = $_POST['customerId'];

    if (empty($customerId)) {
        echo json_encode(array("success" => false, "message" => "Customer ID is required"));
        exit;
    }

    $sql = "SELECT c.id AS cartItemId,c.productId AS productId,p.name AS productName, p.price AS productPrice, p.image AS productImage
            FROM cart c
            INNER JOIN product p ON c.productId = p.id
            WHERE c.customerId = ?";

    if ($stmt = $con->prepare($sql)) {
        $stmt->bind_param("i", $customerId);

        if ($stmt->execute()) {
            $result = $stmt->get_result();
            $cartItems = array();

            while ($row = $result->fetch_assoc()) {
                // Ensure the product image is encoded properly if it's binary data
                if (isset($row['productImage'])) {
                    $row['productImage'] = base64_encode($row['productImage']);
                }
                $cartItems[] = $row;
            }

            $stmt->close();
            $con->close();

            if (!empty($cartItems)) {
                header('Content-Type: application/json');
                echo json_encode(array("success" => true, "cartItems" => $cartItems));
            } else {
                header('Content-Type: application/json');
                echo json_encode(array("success" => false, "message" => "No cart items found for the customer"));
            }
        } else {
            header('Content-Type: application/json');
            echo json_encode(array("success" => false, "message" => 'Execute failed: (' . $stmt->errno . ') ' . $stmt->error));
        }
    } else {
        header('Content-Type: application/json');
        echo json_encode(array("success" => false, "message" => 'Prepare failed: (' . $con->errno . ') ' . $con->error));
    }
} else {
    header('Content-Type: application/json');
    echo json_encode(array("success" => false, "message" => 'Invalid request method'));
}
?>
