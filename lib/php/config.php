<?php 

// config also changeable
  header("Access-Control-Allow-Origin: *");
  $username="btsquare_a00000";
	$password="#000000#0000"; 
	$hostname="localhost";
	$db_name="0000_000"; 
	

	$connect=mysqli_connect($hostname,$username,$password,$db_name);
    

	if(!$connect)
	{
		echo json_encode("Connection Failed");
	}

    if($connect){
      //  echo json_encode("Connection done!!!");
    }
 

	

	?>