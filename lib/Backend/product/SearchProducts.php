<?php

require_once '../connection.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {

    $searchKeyword = $_POST['searchKeyword'] ?? '';

    if (empty($searchKeyword)) {
        echo json_encode(array('error' => 'Search keyword is required'));
        exit;
    }

    $sql = "SELECT * FROM product WHERE name LIKE ?";
    $stmt = $con->prepare($sql);

    if ($stmt === false) {
        echo json_encode(array('error' => 'Failed to prepare statement'));
        exit;
    }

    $searchTerm = '%' . $searchKeyword . '%';
    $stmt->bind_param('s', $searchTerm);

    $stmt->execute();
    $result = $stmt->get_result();
    $items = array();

    if ($result->num_rows > 0) {
        while ($row = $result->fetch_assoc()) {
            $items[] = [
                'id' => $row['id'],
                'item_name' => $row['name'],
                'price' => $row['price'],
                'image' => base64_encode($row['image'])
            ];
        }
    }


    $stmt->close();
    $con->close();

    // header('Content-Type: application/json');
    echo json_encode(array('items' => $items));
}
?>
