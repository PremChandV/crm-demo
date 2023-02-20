<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: Access-Control-Allow-Origin, Accept");

	include "config.php";

	if(isset($_POST))
	{
		$orgCode = $_POST['org_code'];
		$orgName = $_POST['org_name'];
		$phoneNo = $_POST['phone_no'];
		$fax = $_POST['fax'];
		$emailId = $_POST['email_id'];
		$website = $_POST['website'];
		$address = $_POST['address'];
		$regNo = $_POST['reg_no'];
		$regTo = $_POST['reg_to'];
		$regDate = $_POST['reg_date'];
		$sector = $_POST['sector'];
		$socialLinks = $_POST['social_links'];

		$sql = "SELECT org_code AND org_name FROM tbl_clients WHERE procuct_code = '".$orgCode."' AND product_name = '".$orgName."'";

		$result = mysqli_query($connect, $sql);
		$count = mysqli_num_rows($result);

		if ($count == 1) {
			$msg = json_encode("Error");
			echo $msg;
		} else {
			$insert = "INSERT INTO tbl_clients (org_code, org_name, 
												phone_no, fax, 
												email_id, website, 
												address, reg_no, reg_to, reg_date, sector, social_links)
				VALUES('".$orgCode."','".$orgName."', 
						'".$phoneNo."', '".$fax."', 
						'".$emailId."', '".$website."', 
						'".$address."', '".$regNo."', 
						'".$regTo."', '".$regDate."',
						'".$sector."', '".$socialLinks."')";
			$q = mysqli_query($connect, $insert);
			if ($q) {
				echo "New Client added Successfully..!";
			} 
		}
	}

?>