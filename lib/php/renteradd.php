<?php


include "config.php";
	

$name = mysqli_real_escape_string($connect, $_POST['name']);
$number = mysqli_real_escape_string($connect, $_POST['number']);
$date = mysqli_real_escape_string($connect, $_POST['date']);
$amount = mysqli_real_escape_string($connect, $_POST['amount']);
$note = mysqli_real_escape_string($connect, $_POST['note']);

$query = "INSERT INTO `renter` ( `name`, `number`,`date`,`amount`,`note`)
          VALUES ( '$name','$number','$date','$amount','$note')";
		  

$results = mysqli_query($connect, $query);

if($results) {
	$last_id = mysqli_insert_id($connect); // get the ID of the last inserted record
	$response = array('status' => 'success', 'last_id' => $last_id);
	
	echo json_encode($response); // send response as JSON
  } else {
	$response = array('status' => 'error', 'message' => 'Failed to insert record');
	echo json_encode($response);
	
  }


if($results>0)
{
 // header('Location: success.php');
  exit();
}



$connect->close();
?>
