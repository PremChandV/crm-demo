<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: Access-Control-Allow-Origin, Accept");

	include "config.php";

	if(isset($_POST))
	{
		$firstname = $_POST['firstname'];
		$lastname = $_POST['lastname'];

		$sql = "SELECT fistname AND lastname FROM tbl_login WHERE firstname = '".$firstname."' AND lastname = '".$lastname."'";

		$result = mysqli_query($connect, $sql);
		$count = mysqli_num_rows($result);

		if ($count == 1) {
			$msg = json_encode("Error");
			echo $msg;
		} else {
			$insert = "INSERT INTO tbl_login (firstname, lastname)
				VALUES('".$firstname."','".$lastname."')";
			$q = mysqli_query($connect, $insert);
			if ($q) {
				echo "New User added Successfully..!";
			} 
		}
	}

?>