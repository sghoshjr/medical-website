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
    <script type="text/javascript" src="js/jquery.min.js"></script>
    <script type="text/javascript" src="js/bootstrap.js"></script>
    <script type="text/javascript" src="js/bootstrap.min.js"></script>
    

    <!-- Additional Styles -->
    <style type="text/css">
        #ad {
            max-width: 800px;
            max-height: 700px;
            height: auto;
            position: relative;
            overflow: auto;
            overflow-x:hidden;
            padding-left: 30px;
            border: solid rgba(0, 0, 255, 0.075) 3px;
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
            <a class="nav-link" href="#">Medicine Info <span class="sr-only">(current)</span></a>
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
        <h3 class="display-4" align="center">Medicine Info</h3>
      	<br /><br />

        <?php

              $server = 'localhost';
              $username = 'root';
              $password = 'root43214';
              $database = 'medicine';


              //$mid = $_POST['mid'];
              $mid = $_GET['mid'];

              $db = mysqli_connect($server, $username, $password, $database)
                    or die('<b>Error Connecting to MySQL Server or Else DB Not Found!</b>');
                

              $query = "SELECT * FROM medicine m WHERE m.M_ID = $mid";

              $result = mysqli_query($db, $query);

              $row = mysqli_fetch_array($result);
              
              echo "<h2>".$row['Name']."&trade;</h2> <button class='btn btn-success' style='float: right; margin-right: 50px;'>In Stock</button><br />";
              echo "<h4>Information</h4><br/>";
              echo $row['Info'];
              echo "<br /><br /><br /><h4>Price : </h4> Rs.   ".$row['Price']."/- <br /><br /><br />";
              // Dosage to be Echoed
              ?>

              <div id="ad" style="float: right; margin-top: 50px;">
                <?php

                  $query = "
                            CREATE TEMPORARY TABLE IF NOT EXISTS apricetemp AS (
                            SELECT c.C_ID FROM medicine m, composition c WHERE m.M_ID = c.M_ID AND m.M_ID = $mid);
      
                              CREATE TEMPORARY TABLE IF NOT EXISTS bpricetemp AS (
                              SELECT c.C_ID FROM medicine m, composition c WHERE m.M_ID = c.M_ID AND m.M_ID = $mid);
     
                              CREATE TEMPORARY TABLE IF NOT EXISTS cpricetemp AS (
                              SELECT m.M_ID as `M_ID`, m.Name as `Name`, m.Price, c.C_ID FROM medicine m, composition c WHERE m.M_ID = c.M_ID );
        
                              SELECT * FROM cpricetemp WHERE C_ID IN (SELECT * FROM bpricetemp) GROUP BY M_ID
                               HAVING COUNT(*) = (SELECT count(*) FROM apricetemp) ORDER BY Price;
                               
                               ";

                    
                    echo "<br /><br /><h3>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Other Similar Medicines&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</h3><br />";

                    if (mysqli_multi_query($db, $query)) {
                     do {
                            if ($result = mysqli_store_result($db)) {
                              if (mysqli_num_rows($result) != 0) {
                                while ($row = mysqli_fetch_row($result)) {
                                    $t = $row[0];
                                    echo "<li><a href='medicine-info.php?mid=$t'>".$row[1]."</a>  Rs. ".$row[2]." /- <br />";
                                }
                              }
                               mysqli_free_result($result);
                            }
                        } while (mysqli_next_result($db));
                    }

                    echo "<br /><br /><br /><br />";
                ?>

              </div>

              <?php

              
              $query = "SELECT * FROM medicine m, med_type t WHERE m.M_ID = $mid AND m.M_ID = t.M_ID;";
              $result = mysqli_query($db, $query);

              echo "<h4> Type </h4><br />This medication is available as : <br />";

              while ($row = mysqli_fetch_array($result)) {
                  echo "<li>".$row['type']."<br />";
              }


              $query = "SELECT * FROM medicine m, composition cmp, components c WHERE m.M_ID = $mid AND m.M_ID = cmp.M_ID AND cmp.C_ID = c.C_ID";
              $result = mysqli_query($db, $query);

              echo "<br /><br /><br /><h4>Composition</h4>";

              while ($row = mysqli_fetch_array($result)) {
                  $cid = $row['C_ID'];
                  echo "<li><a href='drug-info.php?cid=$cid'>".$row['cname']."</a><br />";
              }
              
              $query = "SELECT cname, C_ID FROM components WHERE components.C_ID = 
                         (SELECT C_ID2 AS `cnamereq` FROM medicine m, composition cmp, components c, contraindication cin

                            WHERE m.M_ID = $mid AND m.M_ID = cmp.M_ID AND cmp.C_ID = c.C_ID AND c.C_ID = cin.C_ID1)
            
                        UNION

                        SELECT cname, C_ID FROM components WHERE components.C_ID = 
                          (SELECT C_ID1 AS `cnamereq` FROM medicine m, composition cmp, components c, contraindication cin

                              WHERE m.M_ID = $mid AND m.M_ID = cmp.M_ID AND cmp.C_ID = c.C_ID AND c.C_ID = cin.C_ID2)";


              $result = mysqli_query($db, $query);

              echo "<br /><br /><h4>Contraindications</h4><br />";

              if (mysqli_num_rows($result) == 0) {
                echo "<font style='color:green'>No Contraindications!</font> <br />";
              } else {
                while ($row = mysqli_fetch_array($result)) {
                  $cid = $row['C_ID'];
                  echo "<li><a href='drug-info.php?cid=$cid' style='color:red'>".$row['cname']."</a></font><br />";
                }
              }


              $query = "SELECT sname FROM medicine m, symptoms s, treats t
                          WHERE
                             m.M_ID = $mid AND m.M_ID = t.M_ID AND t.S_ID = s.S_ID;";
              $result = mysqli_query($db, $query);

              echo "<br /><br /><h4>Treatment and Diagnosis</h4><br />";
              echo "This Medicine is used to treat the following symptoms/Dieases :-<br />";

               while ($row = mysqli_fetch_array($result)) {
                  echo "<li>".$row['sname']."<br />";
                }
 
              $query = "SELECT sname FROM medicine m, symptoms s, side_effects t
                          WHERE
                             m.M_ID = $mid AND m.M_ID = t.M_ID AND t.S_ID = s.S_ID;";
              $result = mysqli_query($db, $query);

              echo "<br /><br /><h4>Side Effects</h4><br />";

              if (mysqli_num_rows($result) == 0) {
                echo "<font style='color:green'>This Medicine has no known Side Effects. Seek Medical help if you experience any symptoms.</font> <br />";
                } else {
                 echo "This Medicine may cause the following symptoms. Stop using this Drug if any of these symptoms persist or worsen! :-<br /><br />";

                while ($row = mysqli_fetch_array($result)) {

                  echo "<li><font style='color:red'>".$row['sname']."</font><br />";
                }
              } 


              $query = "SELECT * FROM medicine m WHERE m.M_ID = $mid";

              $result = mysqli_query($db, $query);

              $row = mysqli_fetch_array($result);
              echo "<br /><br /><h4>Dosage</h4><br />";
              echo $row['Dosage'];

              $query = "SELECT c.Name from medicine m, manufacturer mf, company c
                          WHERE m.M_ID = $mid AND
                          m.M_ID = mf.M_ID AND mf.C_ID = c.C_ID;";
              $result = mysqli_query($db, $query);

              $row = mysqli_fetch_array($result);

              echo "<br /><br /><br /><h4>Manufactured by</h4><br />";
              echo "<b>".$row['Name']." &copy;&trade; </b><br />";

              mysqli_close($db);
              
        ?>


      <br />
      <br />
    </div>
    

</body>
</html>
