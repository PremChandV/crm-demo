<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: Access-Control-Allow-Origin, Accept");

	include "config.php";

	if(isset($_POST))
	{
		$firstname = $_POST['firstname'];
		$lastname = $_POST['lastname'];
		$job = $_POST['job_role'];
		$email = $_POST['email'];
		$pass = $_POST['password'];
		$gender = $_POST['gender'];
		$extension = $_POST['extension'];
		$mobile = $_POST['mobile'];
		$alterMobile = $_POST['alter_mobile'];
		$birthDate = $_POST['birth_date'];
		$joinDate = $_POST['join_date'];
		$photo = $_POST['photo'];
		$address = $_POST['address'];
		$city = $_POST['city'];
		$country = $_POST['country'];
		$region = $_POST['region'];
		$postalCode = $_POST['postal_code'];
		$reportTo = $_POST['report_to'];
		$description = $_POST['description'];

		$sql = "SELECT fistname AND lastname FROM tbl_sales_team WHERE firstname = '".$firstname."' AND lastname = '".$lastname."'";

		$result = mysqli_query($connect, $sql);
		$count = mysqli_num_rows($result);

		if ($count == 1) {
			$msg = json_encode("Error");
			echo $msg;
		} else {
			$insert = "INSERT INTO tbl_sales_team (firstname, lastname, 
												job_role, email, 
												password, gender, 
												extension, mobile, 
												alter_mobile, birth_date, 
												join_date, photo, 
												address, city, 
												country, region, 
												postal_code, report_to, 
												description)
				VALUES('".$firstname."','".$lastname."', 
						'".$job."', '".$email."', 
						'".$pass."', '".$gender."', 
						'".$extension."', '".$mobile."', 
						'".$alterMobile."', '".$birthDate."',
						'".$joinDate."', '".$photo."',
						'".$address."', '".$city."',
						'".$country."', '".$region."',
						'".$postalCode."', '".$reportTo."',
						'".$description."')";
			$q = mysqli_query($connect, $insert);
			if ($q) {
				echo "New User added Successfully..!";
			} 
		}
	}

?>