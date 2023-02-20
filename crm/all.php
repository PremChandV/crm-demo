<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: Access-Control-Allow-Origin, Accept");

    include "config.php";

    $table = "tbl_sales_team"; // lets create a table named 'tbl_sales_team'.

    $query = $connect->query("SELECT * FROM $table");

    $result = array();
    while ($rowData = $query->fetch_assoc()) {
          $result[] = $rowData;
    }
    echo json_encode($result);
    