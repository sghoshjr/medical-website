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
    <script type="text/javascript" src="js/jquery.min.js"></script>

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
        <h3 class="display-4" align="center">Welcome!</h3>
      	<br /><br />

  <?php


        //Get Order ID
        $oid = -1;
        $query = "CALL Insert_User_OrderId();";
        $result  = mysqli_query($db, $query);
        $query = "SELECT O_ID FROM `order` ORDER BY `O_ID` DESC LIMIT 1";
        $result  = mysqli_query($db, $query);
        $row = mysqli_fetch_array($result);
        $oid = $row['O_ID'];
        $uid = $_SESSION['login_id'];
        $query = "CALL order_insert($oid, $uid);";
        $result = mysqli_query($db, $query);

                $query = "SELECT m.M_ID as `#ID`, m.Name as `Medicine`, c.Name as `Company`, m.Price 

                        FROM medicine m, company c, manufacturer mf 

                             WHERE
        
                              m.M_ID = mf.M_ID AND
                              mf.C_ID = c.C_ID ORDER BY m.M_ID;";
              

            $result  = mysqli_query($db, $query);

            echo 
            " <div id='responsecontainer'><table border='1' class='table table-striped table-hover'>
            <thead>
                <tr>
                    <th class='btn-primary'><center>#ID</center></th>
                    <th class='btn-primary'><center>Medicine</center></th>
                    <th class='btn-primary'><center>Company</center></th>
                    <th class='btn-primary'><center>Price</center></th>
                    <th class='btn-primary'><center>Check</center></th>
                    <th class='btn-primary'><center>Qty</center></th>
                </tr>
            </thead>
            <tbody>";
    
            echo '<form id="myform" name="myform" class="myform" method="post">';
            while ($row = mysqli_fetch_array($result))
            {
                $id = $row['#ID'];
                $idcheck = $id.'check';
                $idnum = $id.'num';
                  
                //JAVASCRIPT
                echo '<script type="text/javascript">
                        $(document).ready(function () {

                          $(".clickable-row'.$id.'").click(function() {
                                document.getElementById("'.$idcheck.'").click();
                                if (document.getElementById("'.$idnum.'").value == 0) {
                                    document.getElementById("'.$idnum.'").value = "1";
                                }
                            });
                        });
                      </script>';

                echo '<script type="text/javascript">
                      $(document).ready(function () {
                      $("#'.$idcheck.'").change(function() {  
                       if($(this).is(":checked")) {             
                        var med_id = '.$id.';
                        var med_num = document.getElementById("'.$idnum.'").value;
                        var m_oid = '.$oid.';
                        $.ajax({
                              type: "POST",
                              url: "add_cart.php",        
                              dataType: "html",
                              data: {
                                    med_id,
                                    med_num,
                                    m_oid
                             },
                             cache: false,               
                            
                            success: function(data) {                    
                               $("#responsecontainer2").html(data); 
                            }

                      });
                    } else {
                        var med_id = '.$id.';
                        var med_num = document.getElementById("'.$idnum.'").value;
                        var m_oid = '.$oid.';
                        $.ajax({
                              type: "POST",
                              url: "del_cart.php",        
                              dataType: "html",
                              data: {
                                    med_id,
                                    med_num,
                                    m_oid
                             },
                             cache: false,               
                            
                            success: function(data) {                    
                               $("#responsecontainer2").html(data); 
                            }

                      });
                    }
                 });
                 });
                 </script>';


                echo "<tr class='clickable-row$id' style='cursor: pointer;'>";
                echo "<td>" . $row['#ID'] . "</td>";
                echo "<td>" . $row['Medicine'] . "</td>";
                echo "<td>" . $row['Company'] . "</td>";
                echo "<td>" . $row['Price'] . "</td>";
                echo "<td><div class='checkbox' style='margin-top: auto; margin-bottom: auto; margin-left: auto; padding-left: 50px;'>
                          <label>
                             <input type='checkbox' name='addcheck[]' value=$id  id='$idcheck'><i class='helper'></i></label>
                          </div>" ;

                echo "<td>  <select name='addqty' id=$idnum>
                              <option selected='selected' disabled='disabled' value='0'></option>
                              <option value='1'>&nbsp;&nbsp;1&nbsp;&nbsp;&nbsp;</option>
                              <option value='2'>&nbsp;&nbsp;2&nbsp;&nbsp;&nbsp;</option>
                              <option value='3'>&nbsp;&nbsp;3&nbsp;&nbsp;&nbsp;</option>
                              <option value='4'>&nbsp;&nbsp;4&nbsp;&nbsp;&nbsp;</option>
                              <option value='5'>&nbsp;&nbsp;5&nbsp;&nbsp;&nbsp;</option>
                            </select></td>";                         

                echo "</tr>";

            }

             echo "</tbody><tfoot><tr><td colspan=7><center>Choose the items you want along with the quantity!</center></td></tr></tfoot></table></div>";
             echo '</form>';

      
  ?>
      <br />
      <br />
      <button class="btn btn-danger" id="checkout" name="checkout" style="float: right; margin-right: 150px;" onclick="window.location.href='checkout.php'">Check Out!</button>
    </div>

    




</body>
</html>
