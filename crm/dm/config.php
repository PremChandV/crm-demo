<?php
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: GET, POST');
header("Access-Control-Allow-Credentials: true");  // Required for cookies, authorization headers with HTTPS
header("Access-Control-Allow-Headers: X-Requested-With");

$servername = "localhost";
$username = "root";
$password = "";
$dbname = "crm";

// Create connection
$connect = mysqli_connect($servername, $username, $password, $dbname);
// Check connection
/*if (!$connect ) {
     die("Connection failed: " . mysqli_connect_error());
}
else
{
	echo json_encode("success") ;
} */

?>
