<?php
include '../connection.php';

$orderId = $_POST['orderId'];
$deliveryPersonId = $_POST['deliveryPersonId'];
$date = $_POST['date'];

$sqlCheckStatus = "SELECT state FROM `order` WHERE id = ?";
$stmtCheckStatus = $con->prepare($sqlCheckStatus);
$stmtCheckStatus->bind_param("i", $orderId);
$stmtCheckStatus->execute();
$stmtCheckStatus->store_result();

if ($stmtCheckStatus->num_rows > 0) {
    $stmtCheckStatus->bind_result($currentStatus);
    $stmtCheckStatus->fetch();

    if ($currentStatus === "pending") {

        $sqlInsertDetail = "INSERT INTO `order_detail` (order_id, delivery_person_id, date) VALUES (?, ?, ?)";
        $stmtInsertDetail = $con->prepare($sqlInsertDetail);
        $stmtInsertDetail->bind_param("iis", $orderId, $deliveryPersonId, $date);
        $stmtInsertDetail->execute();

        $sqlUpdateOrder = "UPDATE `order` SET state = 'Delivered' WHERE id = ?";
        $stmtUpdateOrder = $con->prepare($sqlUpdateOrder);
        $stmtUpdateOrder->bind_param("i", $orderId);
        $stmtUpdateOrder->execute();

        if ($stmtUpdateOrder->affected_rows > 0) {
            echo json_encode(array("success" => true, "message" => "Order status updated successfully."));
        } else {
            echo json_encode(array("success" => false, "message" => "Failed to update order status."));
        }
    } else {
        echo json_encode(array("success" => false, "message" => "Order status is not pending. Cannot change status."));
    }
} else {
    echo json_encode(array("success" => false, "message" => "Failed to check order status. Order ID may not exist."));
}

$stmtCheckStatus->close();
$stmtInsertDetail->close();
$stmtUpdateOrder->close();
$con->close();
?>
