<?php 

include "../connection.php";

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
$user_name = $_POST['user_name'];



$sqlquery = $con ->prepare("SELECT * FROM `deliveryperson` WHERE `UserName` = ?");
$sqlquery->bind_param("s", $user_name);
$sqlquery->execute();
$resultOfquery = $sqlquery->get_result();


if ($resultOfquery->num_rows > 0) {
    echo json_encode(array('EmailFound' => true));
} else {
    echo json_encode(array('EmailFound' => false));
}


$sqlquery->close();
$con ->close();
}
?>
