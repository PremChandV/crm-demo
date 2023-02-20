<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: Access-Control-Allow-Origin, Accept");

    include "config.php";
   
    $table = "tbl_products";
 
    // Get all records from the database
    $sql = "SELECT * from $table ORDER BY product_id";
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