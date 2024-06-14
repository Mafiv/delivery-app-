<?php
include '../connection.php';
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: GET");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    $sql = "SELECT 
                c.FirstName AS customer_name,
                c.LastName AS customer_last_name,
                c.image AS customer_image,
                p.name AS product_name,
                p.image AS product_image,
                p.price AS product_price,
                o.location AS customer_address,
                od.date AS order_date,
                dp.FirstName AS delivery_person_name,
                dp.image AS delivery_person_image
            FROM 
                order_detail od
                JOIN `order` o ON od.order_id = o.id
                JOIN customer c ON o.customerId = c.id
                JOIN product p ON o.productId = p.id
                JOIN deliveryPerson dp ON od.delivery_person_id = dp.id";

    $result = $con->query($sql);

    if ($result === false) {
        echo json_encode(array("success" => false, "message" => "Failed to execute SQL statement."));
        exit();
    }

    $data = array();

    while ($row = $result->fetch_assoc()) {
        $row['customer_image'] = base64_encode($row['customer_image']);
        $row['product_image'] = base64_encode($row['product_image']);
        $row['delivery_person_image'] = base64_encode($row['delivery_person_image']);
        $data[] = $row;
    }

    if (count($data) > 0) {
        echo json_encode(array("success" => true, "data" => $data));
    } else {
        echo json_encode(array("success" => false, "message" => "No data found"));
    }

    $con->close();
} else {
    echo json_encode(array("success" => false, "message" => "Invalid request method"));
}
?>
