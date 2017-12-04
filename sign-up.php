<?php

     $server = 'localhost';
     $username = 'root';
     $password = 'root43214';
     $database = 'medicine';
     $db = mysqli_connect($server, $username, $password, $database)
           or die('<b>Error Connecting to MySQL Server or Else DB Not Found!</b>');
      

  $firstname = $_POST['fname'];
  $lastname = $_POST['lname'];
  $email = $_POST['email'];
  $password =  md5($_POST['pass']);
  $mobilenumber = $_POST['mno'];
  $dob=$_POST['dob'];
  $gender=$_POST['gender'];
  $hno=$_POST['hno'];
  $pin=$_POST['pin'];
  $type=$_POST['type'];
  $amt=0;

  $query = "SELECT * FROM user WHERE email = '$email';";

  $result = mysqli_query($db, $query) or die(mysqli_error($db));

  $row = mysqli_fetch_array($result);

  if ($row)
  {
      echo "<script type='text/javascript' src='js/jquery.min.js'></script>
        <script type='text/javascript'>
          $(document).ready(function() {
          alert('SORRY...YOU ARE ALREADY REGISTERED USER...');
        });
        </script>";
    die ("SORRY...YOU ARE ALREADY REGISTERED USER...");
  }

  if ($gender == 'male') {
    $gender = 'M';
  } elseif ($gender == 'female') {
    $gender = 'F';
  } else
  {
    $gender = 'O';
  }

  $query = 
  "INSERT INTO user (`email`,`password`,`first_name`,`last_name`,`phone_no`,`DOB`,`type`,`gender`,`PIN`,`house_no`,`walletamt`)VALUES 
  ('$email','$password','$firstname','$lastname','$mobilenumber','$dob','$type','$gender','$pin','$hno','$amt');";

  $data = mysqli_query ($db, $query)or die(mysqli_error($db));
 
  if($data)
  {
  echo "<script type='text/javascript' src='js/jquery.min.js'></script>
        <script type='text/javascript'>
          $(document).ready(function() {
          alert('Your Registration is Complete...!');
        });
        </script>";
  header("location:user.php");
  }
?>
  