<?php
include "../connection.php";

$sql = "SELECT 
                o.id AS orderId,
                p.name AS productName,
                p.price AS productPrice,
                p.image AS productImage,
                o.state AS orderStatus
            FROM 
                `order` o
            JOIN 
                `product` p ON o.productId = p.id";

$result = $con->query($sql);

$response = array();

if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        if (!empty($row['productImage'])) {
            $row['productImage'] = base64_encode($row['productImage']);
        } else {
            $row['productImage'] = '';
        }
        $response[] = $row;
    }

    echo json_encode(array("response" => $response));
} else {
    echo json_encode(array("response" => $response));
}

$con->close();
?>