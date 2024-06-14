<?php
include '../connection.php';


header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");


$sql = "SELECT * FROM customer";
$result = $con->query($sql);

if ($result->num_rows > 0) {
    $customers = array();
    
    while ($row = $result->fetch_assoc()) {
        $customer = array(
            'id' => $row['id'],
            'FirstName' => $row['FirstName'],
            'LastName' => $row['LastName'],
            'UserName' => $row['UserName'],
            'Gender' => $row['Gender'],
            'PhoneNumber' => $row['PhoneNumber'],
            'image' => base64_encode($row['image']) 
        );
        array_push($customers, $customer);
    }
   
    echo json_encode($customers);
} else {
    
    echo json_encode(array('message' => 'No customers found'));
}

$con->close();
?>
