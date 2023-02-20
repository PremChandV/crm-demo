<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: Access-Control-Allow-Origin, Accept");

	include "config.php";

/*// Get all employee records from the database
if("GET_ALL" == $action){
$db_data = array();
$sql = "SELECT id, first_name, last_name from $table ORDER BY id DESC";
$result = $conn->query($sql);
if($result->num_rows > 0){
while($row = $result->fetch_assoc()){
$db_data[] = $row;
}
// Send back the complete records as a json
echo json_encode($db_data);
}else{
echo "error";
}
$conn->close();
return;
} */


    // Give your table name
    $table = "users"; // lets create a table named Employees.

    // Get all records from the database
    $sql = "SELECT * from $table ORDER BY user_id ";
    $db_data = array();
 
    $result = $connect->query($sql);
    if($result->num_rows > 0){
        while($row = $result->fetch_assoc()) {
            $db_data[] = $row;
        }
        // Send back the complete records as a json
        echo json_encode($db_data);
    }else{
        echo "error";
    }
    $connect->close();
    
    return;

?>
