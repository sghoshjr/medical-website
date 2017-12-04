<?php
   	$server = 'localhost';
    $username = 'root';
    $password = 'root43214';
    $database = 'medicine';


    $db = mysqli_connect($server, $username, $password, $database)
          or die('<b>Error Connecting to MySQL Server or Else DB Not Found!</b>');

   session_start();
   
   $user_check = $_SESSION['login_user'];
   
   $ses_sql = mysqli_query($db,"select U_ID, first_name, last_name from user where email = '$user_check' ");
   
   $row = mysqli_fetch_array($ses_sql,MYSQLI_ASSOC);
   
   $_SESSION['login_id'] = $row['U_ID'];
   $login_session_first = $row['first_name'];
   $login_session_last  = $row['last_name'];
   
   if(!isset($_SESSION['login_user'])){
      header("location:user.php");
   }

   /*
	
	            $_SESSION['login_user'];   //Stores the Email ID
                $_SESSION['login_id'];	   //Stores the User-ID
                $login_session_first;	   //Stores First Name
   				$login_session_last;	   //Stores Last Name
	
   */
?>
