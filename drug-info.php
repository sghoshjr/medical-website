<!DOCTYPE html>
<html lang="en">
<head>

    <title>Medicine Information</title>

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
    <script type="text/javascript" src="js/bootstrap.js"></script>
    <script type="text/javascript" src="js/bootstrap.min.js"></script>
    <script type="text/javascript" src="js/jquery.min.js"></script>

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
          <li class="nav-item active">
            <a class="nav-link" href="#">Drug Info <span class="sr-only">(current)</span></a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="Admin.html">Admin CP</a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="user.php">Log - In</a>
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
        <h3 class="display-4" align="center">Drug Info</h3>
      	<br /><br />

        <?php

              $server = 'localhost';
              $username = 'root';
              $password = 'root43214';
              $database = 'medicine';

              $cid = $_GET['cid'];

              $db = mysqli_connect($server, $username, $password, $database)
                    or die('<b>Error Connecting to MySQL Server or Else DB Not Found!</b>');
                

              $query = "SELECT c.cname, m.Name, m.M_ID from components c, medicine m, composition cmp WHERE
                         c.C_ID = $cid AND
                           c.C_ID = cmp.C_ID AND
                             cmp.M_ID = m.M_ID;";

              $result = mysqli_query($db, $query);

              if (mysqli_num_rows($result) == 0) {
                die ('<h5>No Medicine contains this Drug!</h5>');
              }

              $row = mysqli_fetch_array($result);


              
              echo "<h2>Medicines that contain <b>".$row[cname]."</b></h2><br/>";
              $mid = $row['M_ID'];
              echo "<h5><a href='medicine-info.php?mid=$mid'>".$row['Name']."&trade;</a></h5><br />";

              while ($row = mysqli_fetch_array($result)) {
                  $mid = $row['M_ID'];
                  echo "<h5><a href='medicine-info.php?mid=$mid'>".$row['Name']."&trade;</a></h5><br />";
              }
              
              mysqli_close($db);
              
        ?>


      <br />
      <br />
    </div>
    

</body>
</html>
