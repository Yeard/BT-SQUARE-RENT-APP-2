<?php 
    include "config.php";
    $renters_ids = mysqli_real_escape_string($connect, $_POST['renters_ids']);
    $dates = mysqli_real_escape_string($connect, $_POST['dates']);   
    $amounts = mysqli_real_escape_string($connect, $_POST['amounts']);
    $notes = mysqli_real_escape_string($connect, $_POST['notes']);
    $types = mysqli_real_escape_string($connect, $_POST['types']);
    $querys = "INSERT INTO `subtransaction` (`renters_id`,  `date`, `amount`, `note`, `type`)
               VALUES('$renters_ids', '$dates','$amounts','$notes','$types')";
    $resultss = mysqli_query($connect, $querys);
    $last_id = mysqli_insert_id($connect);
    if($resultss>0)
    {
      // Return the last inserted ID as a JSON response
      $response = array(
        'status' => 'success',
        'last_ids' => $last_id
      );
     
      echo json_encode($response);
    }
    else
    {
      
      $response = array('status' => 'error');
     
      echo json_encode($response);
    }
    $connect->close();   
?>
