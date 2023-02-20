<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: Access-Control-Allow-Origin, Accept");

    include "config.php";
    
    //initialized name by user requirement = Column name in DB
    $user = $_POST['email'];
    $pass = $_POST['password'];

    $q = $connect->query("SELECT * FROM tbl_sales_team WHERE email ='".$user."' and password = '".$pass."'");
    $result = array();

    while($fetchData = $q->fetch_assoc()) {
        $result[] = $fetchData;
    }
    echo json_encode($result);

?>
