<?php

              $server = 'localhost';
              $username = 'root';
              $password = 'root43214';
              $database = 'medicine';


              $db = mysqli_connect($server, $username, $password, $database)
                    or die('<b>Error Connecting to MySQL Server or Else DB Not Found!</b>');
                

              session_start();

              if(isset($_SESSION['login_user'])){
                header("location:welcome.php");
                }
   
            if($_SERVER["REQUEST_METHOD"] == "POST") {

              $myusername = mysqli_real_escape_string($db,$_POST['username']);           //Email
              $mypassword = md5(mysqli_real_escape_string($db,$_POST['password']));      //Password
              //The password is hashed using MD5 Hashing

              $sql = "SELECT U_ID FROM user WHERE email = '$myusername' and password = '$mypassword'";
              $result = mysqli_query($db, $sql);
              $row = mysqli_fetch_array($result,MYSQLI_ASSOC);
      
              $count = mysqli_num_rows($result);

              if($count == 1) {
                $_SESSION['login_user'] = $myusername;
                $_SESSION['login_id'] = $row['U_ID'];
         
                header("location: welcome.php");        //BackUp welcome2.php
              } else {
                $error = "Your Login Name or Password is invalid";
              }
            }
            mysqli_close($db);
              
        ?>
<html lang="en">
<head>

    <title>Log - In Page</title>

    <!-- Metadata -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="Online Medicine Catalogue">
    <meta name="author" content="Saptarshi Ghosh">
    <link rel="icon" href="img/favicon.png">


    <!-- CSS -->
    <link href="css/bootstrap.css" rel="stylesheet">
    <link href="css/jumbotron.css" rel="stylesheet">
    <link href="css/material.css" rel="stylesheet">

    <!-- Javascript -->
    <script type="text/javascript" src="js/jquery.min.js"></script>
    <script type="text/javascript" src="js/bootstrap.js"></script>
    <script type="text/javascript" src="js/bootstrap.min.js"></script>
    

    <!-- Additional Styles -->
    <style type="text/css">
        #responsecontainer {
            max-width: 800px;
            max-height: 700px;
            height: auto;
            align-content: center;
            align-items: center;
            text-align: center;
            position: relative;
            overflow: auto;
            overflow-x:hidden;
            margin: 0 auto;
        }
    </style>

</head>

<body>

    <!-- Navigation Bar -->
    <nav class="navbar navbar-expand-md navbar-dark fixed-top bg-dark">
      <a class="navbar-brand" href="#">Navigation</a>
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarsExampleDefault" aria-controls="navbarsExampleDefault" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>

      <div class="collapse navbar-collapse" id="navbarsExampleDefault">
        <ul class="navbar-nav mr-auto">
          <li class="nav-item">
            <a class="nav-link" href="index.html">Home</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="Admin.html">Admin CP</a>
          </li>
          <li class="nav-item active">
            <a class="nav-link" href="user.php">Log - In<span class="sr-only">(current)</span></a>
          </li>
        </ul>
        <form class="form-inline my-2 my-lg-0">
          <input class="form-control mr-sm-2" type="text" placeholder="Search" aria-label="Search">
          <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
        </form>
      </div>
    </nav>


    <!-- Main WebPage -->
    <div class="jumbotron">
        <h3 class="display-4" align="center">Log-In</h3>
      	<br /><br />


        <div align = "center">
         <div style = "width:300px; border: solid 1px #333333; " align = "left">
            <div style = "background-color:#333333; color:#FFFFFF; padding:3px;"><b>Login</b></div>
        
            <div style = "margin:30px">
               
               <form action = "" method = "post">
                  <div class="input-group">
                    <span class="input-group-addon" id="sizing-addon2">@</span>
                    <input type="email" class="form-control" name="username" placeholder="Username" aria-describedby="sizing-addon2">
                  </div>
                  <div class="input-group">
                    <span class="input-group-addon" id="sizing-addon2">@</span>
                    <input type="password" class="form-control" name="password" placeholder="Password" aria-describedby="sizing-addon2">
                  </div>
                  <br /><br />
                  <input type = "submit" class="btn btn-primary" value = " Log in "/><br />
               </form>
               
               <div style = "font-size:11px; color:#cc0000; margin-top:10px"><?php echo $error; ?></div>
          
            </div>
        
           </div>
      
         </div>
        <br />
        <br />
        <center>Click here to sign up!<button name="signup" onclick="location.href='signup.html'" class="btn btn-primary" style="position: relative; margin-left: 30px;">Sign Up</button></center>
        <br />
        <br />
     </div>
    

</body>
</html>
