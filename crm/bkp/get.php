<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: Access-Control-Allow-Origin, Accept");

    include "config.php";
   
/*     $servername = "localhost";
 
    // Give your username and password
    $username = "root";
    $password = "";
 
   // Give your Database name
    $dbname = "crm"; */
 
  // Give your table name
    $table = "users"; // lets create a table named Employees.
     
/*     // Create Connection
    $connect = new mysqli($servername, $username, $password, $dbname);
    // Check Connection
    if($connect->connect_error){
        die("Connection Failed: " . $conn->connect_error);
        return;
    } */
 
    // Get all records from the database
 
    $sql = "SELECT * from $table ORDER BY user_id ";
    $db_data = array();
 
    $result = $connect->query($sql);
    if($result->num_rows > 0){
        while($row = $result->fetch_assoc()){
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