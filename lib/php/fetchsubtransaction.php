<?php
include "config.php";


$sql = "SELECT * FROM subtransaction";
$result = mysqli_query($connect, $sql);

if (mysqli_num_rows($result) > 0) {
 
  $renterData = array();
  
 
  while($row = mysqli_fetch_assoc($result)) {
    $renterData[] = $row;
  }

  $renterDataJson = json_encode($renterData);
  
  // Set the content type of the response to JSON
  header('Content-Type: application/json');
  
  // Send the JSON-encoded renter data as the response
  echo $renterDataJson;
} else {
  // Send a JSON-encoded error message as the response
  $error = array('error' => 'No renter data found');
  echo json_encode($error);
}

mysqli_close($connect);
?>