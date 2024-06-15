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
            product p ON o.productId = p.id
      

$result = $conn->query($sql);

if ($result->num_rows > 0) {
    $response = array();
    while($row = $result->fetch_assoc()) {
       
        $row['productImage'] = base64_encode($row['productImage']);
        $response[] = $row;
    }
    echo json_encode($response);
} else {
    echo json_encode(array("message" => "NO Item Found"));
}

$conn->close();
?>
