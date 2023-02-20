<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: Access-Control-Allow-Origin, Accept");

	include "config.php";

	if(isset($_POST))
	{
		$productCode = $_POST['procuct_code'];
		$productName = $_POST['product_name'];
		$quantity = $_POST['quantity'];
		$price = $_POST['price'];
		$category = $_POST['category'];
		$productDetails = $_POST['product_details'];
		$supplier = $_POST['supplier'];
		$empId = $_POST['emp_id'];
		$assignedTo = $_POST['assigned_to'];

		$sql = "SELECT procuct_code AND product_name FROM tbl_products WHERE procuct_code = '".$productCode."' AND product_name = '".$productName."'";

		$result = mysqli_query($connect, $sql);
		$count = mysqli_num_rows($result);

		if ($count == 1) {
			$msg = json_encode("Error");
			echo $msg;
		} else {
			$insert = "INSERT INTO tbl_products (procuct_code, product_name, 
												quantity, price, 
												category, product_details, 
												supplier, emp_id, assigned_to)
				VALUES('".$productCode."','".$productName."', 
						'".$quantity."', '".$price."', 
						'".$category."', '".$productDetails."', 
						'".$supplier."', '".$empId."', 
						'".$assignedTo."')";
			$q = mysqli_query($connect, $insert);
			if ($q) {
				echo "New Product added Successfully..!";
			} 
		}
	}

?>