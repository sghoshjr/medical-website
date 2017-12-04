<?php
    include ('session.php');
?>

<!DOCTYPE html>
<html lang="en">
<head>

    <title>Welcome!</title>

    <!-- Metadata -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="User Welcome Page">
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
            max-width: 1000px;
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
        #responsecontainer2 {
            max-width: 1000px;
            max-height: 700px;
            height: auto;
            align-content: center;
            align-items: center;
            text-align: center;
            position: relative;
            overflow: auto;
            overflow-x:hidden;
            margin: 0 auto;
            margin-bottom: 50px;
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
            <a class="nav-link" href="welcome.php">User</a>
          </li>
        </ul>
        <ul class="navbar-nav navbar-right">
          <li class="nav-item disabled">
            <a class="nav-link"><b>Welcome <?php echo $login_session_last." ".$login_session_first?> !  </b></a>
          </li>
          <li class="nav-item active">
            <a class="nav-link" href="logout.php">Log - Out</a>
          </li>
        </ul>

      </div>
      
    </nav>


    <!-- Main WebPage -->
    <div class="jumbotron">
        <h3 class="display-4" align="center">Your Cart</h3>
      	<br /><br />

  <?php


        //Get Order ID
        $oid = -1;
        $query = "SELECT O_ID FROM `order` ORDER BY `O_ID` DESC LIMIT 1";
        $result  = mysqli_query($db, $query);
        $row = mysqli_fetch_array($result);
        $oid = $row['O_ID'];
        $sum = 0;
        $sum2 = 0;

                $query = "SELECT om.M_ID, m.Name as `Mname`, c.Name as `Cname`, Price, quantity FROM `order_medicine` AS om, `medicine` AS m,
                          `company` as c, `manufacturer` as mf

                             WHERE om.M_ID = m.M_ID AND
                                   mf.M_ID = om.M_ID AND
                                   mf.C_ID = c.C_ID AND
        
                              O_ID = $oid;";
              

            $result  = mysqli_query($db, $query);

            echo 
            " <div id='responsecontainer'><table border='1' class='table table-striped table-hover'>
            <thead>
                <tr>
                    <th class='btn-primary'><center>#ID</center></th>
                    <th class='btn-primary'><center>Medicine</center></th>
                    <th class='btn-primary'><center>Company</center></th>
                    <th class='btn-primary'><center>Price</center></th>
                    <th class='btn-primary'><center>Qty</center></th>
                </tr>
            </thead>
            <tbody>";
    
            while ($row = mysqli_fetch_array($result))
            {      

                echo "<tr>";
                echo "<td>" . $row['M_ID'] . "</td>";
                echo "<td>" . $row['Mname'] . "</td>";
                echo "<td>" . $row['Cname'] . "</td>";
                echo "<td>" . $row['Price'] . "</td>";
                echo "<td>" . $row['quantity'] . "</td>";                       
                echo "</tr>";
                $sum += $row['Price'] * $row['quantity'];
                $sum2 += $row['quantity'];

            }

             echo "</tbody><tfoot><tr><td colspan=3><center>Proceed to Payment!</center></td>
                   <td class='btn-info disabled'><b> &#8377; ".$sum." </b></td>
                   <td> ".$sum2."</td>
                   </tr></tfoot></table></div>";

      
  ?>
      <br />
      <br />
      </div>
    <script type="text/javascript">

    $(document).ready(function() {

         $("#pay").click(function() {
          var total = <?php echo $sum; ?>;
            $.ajax({
                type: "POST",
                url: "ret_balance.php",        
                dataType: "html",
                data: {
                    total
                },
                cache: false,               
                success: function(data) {                    
                    $("#responsecontainer2").html(data); 
                }

            });
            this.disabled = true;
        });
    });

    </script>
      <button class="btn btn-success" id="pay" name="pay" style="float: right; margin-right: 150px;">Proceed to Payment!</button>
    

    <div id="responsecontainer2"> </div>
    <br />
    <br />


    




</body>
</html>
