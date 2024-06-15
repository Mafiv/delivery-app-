<?php
include '../connection.php';

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    $sql = "SELECT * FROM product";
    $result = $con->query($sql);

    if ($result->num_rows > 0) {
        $items = array();
        while ($row = $result->fetch_assoc()) {
            $items[] = array(
                'id' => $row['id'],
                'item_name' => $row['name'],
                'image' => base64_encode($row['image']),
                'price' => $row['price'],
        
            );
        }

        // Set the response headers
        header('Content-Type: application/json');

        // Send the JSON response
        echo json_encode($items);
    } else {
        // Set the response headers
        header('Content-Type: application/json');

        // Send a JSON response indicating that no items were found
        echo json_encode(array('message' => 'No items found'));
    }

    // Stop further execution
    exit;
}



?>