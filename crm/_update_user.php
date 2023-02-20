<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: Access-Control-Allow-Origin, Accept");

    include "config.php";
   
    $table = "tbl_sales_team"; // lets create a table named 'tbl_sales_team'.

    $id = $_POST['user_id'];
    $firstname = $_POST['firstname'];
	$lastname = $_POST['lastname'];
    //$age = (int) $_POST['age'];
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
 
    // Get all records from the database
    $sql = "UPDATE `tbl_sales_team` SET `user_id`='.$id.', `firstname`='".$firstname."',
                `lastname`='".$lastname."', `job_role`='".$job."', `email`='".$email."',
                `password`='".$pass."', `gender`='".$gender."', `extension`='".$extension."',
                `mobile`='".$mobile."', `alter_mobile`='".$alterMobile."', `birth_date`='".$birthDate."',
                `join_date`='".$joinDate."', `photo`='".$photo."', `address`='".$address."',
                `city`='".$city."', `country`='".$country."', `region`='".$region."',
                `postal_code`='".$postalCode."', `report_to`='".$reportTo."',`
                description`='".$description."' WHERE user_id";
    $db_data = array();
 
    $result = $connect->query($sql);
    /* if($result->num_rows > 0){
        while($row = $result->fetch_assoc()){
            $db_data[] = $row;
        }
        // Send back the complete records as a json
        echo json_encode($db_data);
    }else{
        echo "error";
    } */
    if($result = $connect->query($sql))
    {
        echo json_encode([
            'success' => $result
        ]);
    }
    else {
        echo json_encode([
            'failed' => $result
        ]);
    }
    /* echo json_encode([
        'success' => $result
    ]); */

    $connect->close();
    
    return;
 
?>