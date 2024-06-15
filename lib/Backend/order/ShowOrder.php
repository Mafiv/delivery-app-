<?php
include "../connection.php";

// Sanitize input to prevent SQL injection
$customerId = isset($_POST['customerId']) ? intval($_POST['customerId']) : 1;

if ($customerId > 0) {
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
            WHERE 
                o.customerId = ?"; 

    if ($stmt = $con->prepare($sql)) {
        // Bind parameters
        $stmt->bind_param("i", $customerId);

        // Execute the statement
        $stmt->execute();

        // Get the result
        $result = $stmt->get_result();

        if ($result->num_rows > 0) {
            $response = array();
            while ($row = $result->fetch_assoc()) {
                if (!empty($row['productImage'])) {
                    // Ensure the productImage is a valid binary before encoding
                    $row['productImage'] = base64_encode($row['productImage']);
                } else {
                    $row['productImage'] = '';
                }
                $response[] = $row;
            }
            echo json_encode($response);
        } else {
            echo json_encode(array("message" => "No orders found for the specified customer ID"));
        }

        // Close the statement
        $stmt->close();
    } else {
        echo json_encode(array("message" => "Failed to prepare the SQL statement"));
    }
} else {
    echo json_encode(array("message" => "Invalid customer ID"));
}

// Close the connection
$con->close();
?>
