<?php 
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: Access-Control-Allow-Origin, Accept");

	include "config.php";

	    $name = mysqli_real_escape_string($connect, $_REQUEST['lastname']);
	    $email = mysqli_real_escape_string($connect, $_REQUEST['email']);
	    $mobile = mysqli_real_escape_string($connect, $_REQUEST['mobile']);

	    $query = "INSERT INTO dm(lastname, email, mobile)
	  			  VALUES('$name', '$email','$mobile')"; 
		//$query = $connect->query("INSERT INTO tbl_login(`lastname`, `email`, `mobile`) VALUES ('$name','$email','$mobile')");
	    $result = mysqli_query($connect, $query);
	    if($result == 0)
	    {
	        echo "User added Successfully..!";
	    }
		/*else {
			echo "Registration Failed..!";
		} */

?>