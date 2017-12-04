<html>
<head>
    <link rel="stylesheet" href="css/greentable.css">
    <script type="text/javascript" src="js/jquery.min.js"></script>

    <script type="text/javascript">
        jQuery(document).ready(function($) {
             $(".clickable-row").click(function() {
            window.location = $(this).data("href");
            });
        });
    </script>
    
</head>
<body>

<?php


    $server = 'localhost:3306';
    $username = 'root';
    $password = 'root43214';
    $database = 'medicine';

    $keyword = $_POST['Keyword'];
    $sradio = $_POST['Sradio'];

    $db = mysqli_connect($server, $username, $password, $database)
        or die('<b>Error Connecting to MySQL Server or Else DB Not Found!</b>');
    

    if (isset($keyword)) {

        if ($sradio == "medicine") {

            if ($keyword == '') {

                $query = "SELECT m.M_ID as `#ID`, m.Name as `Medicine`, c.Name as `Company`, m.Price 

                        FROM medicine m, company c, manufacturer mf 

                             WHERE
        
                              m.M_ID = mf.M_ID AND
                              mf.C_ID = c.C_ID ORDER BY m.M_ID LIMIT 25;";
                } else {

                $query = "SELECT m.M_ID as `#ID`, m.Name as `Medicine`, c.Name as `Company`, m.Price 

                        FROM medicine m, company c, manufacturer mf 

                             WHERE
        
                              m.M_ID = mf.M_ID AND
                              mf.C_ID = c.C_ID AND m.Name LIKE '%$keyword%' ORDER BY m.M_ID LIMIT 25;";
            }

            $result  = mysqli_query($db, $query);

            if (mysqli_num_rows($result) == 0) {
        
                echo "<table border='1' class='greenTable'><tfoot><tr><td colspan=5>No Results Found!</td></tr></tfoot></table>";

            } else {

            echo 
            " <table border='1' class='greenTable table-hover'>
            <thead>
                <tr>
                    <th>#ID</th>
                    <th>Medicine</th>
                    <th>Company</th>
                    <th>Price</th>
                </tr>
            </thead>
            <tbody>";
    

            while ($row = mysqli_fetch_array($result))
            {
                $id = $row['#ID'];
                echo "<tr class='clickable-row' data-href='medicine-info.php?mid=$id' style='cursor: pointer;'>";
                echo "<td>" . $row['#ID'] . "</td>";
                echo "<td>" . $row['Medicine'] . "</td>";
                echo "<td>" . $row['Company'] . "</td>";
                echo "<td>" . $row['Price'] . "</td>";
                echo "</tr>";

            }

             echo "</tbody><tfoot><tr><td colspan=5>Displaying Top 25 Searches!</td></tr></tfoot></table>";
    
            }
        } 

        elseif ($sradio == "company") {
            if ($keyword == '') {

                $query = "SELECT C_ID, Name, c.PIN, p.Area, p.City, p.State, p.Country 
                            FROM company c, pin_address p WHERE
    
                            c.PIN = p.PIN ORDER BY C_ID LIMIT 25;";

                } else {

                $query = "SELECT C_ID, Name, c.PIN, p.Area, p.City, p.State, p.Country 
                            FROM company c, pin_address p WHERE
    
                            c.PIN = p.PIN AND
                            Name LIKE '%$keyword%' ORDER BY C_ID LIMIT 25;";
            }

            $result  = mysqli_query($db, $query);

            if (mysqli_num_rows($result) == 0) {
        
                echo "<table border='1' class='greenTable'><tfoot><tr><td colspan=7>No Results Found!</td></tr></tfoot></table>";

            } else {

            echo 
            " <table border='1' class='greenTable'>
            <thead>
                <tr>
                    <th>#ID</th>
                    <th>Company</th>
                    <th>PIN</th>
                    <th>Area</th>
                    <th>City</th>
                    <th>State</th>
                    <th>Country</th>
                </tr>
            </thead>
            <tbody>";
    

            while ($row = mysqli_fetch_array($result))
            {
                echo "<tr>";
                echo "<td>" . $row['C_ID'] . "</td>";
                echo "<td>" . $row['Name'] . "</td>";
                echo "<td>" . $row['PIN'] . "</td>";
                echo "<td>" . $row['Area'] . "</td>";
                echo "<td>" . $row['City'] . "</td>";
                echo "<td>" . $row['State'] . "</td>";
                echo "<td>" . $row['Country'] . "</td>";
                echo "</tr>";

            }

             echo "</tbody><tfoot><tr><td colspan=7>Displaying Top 25 Searches!</td></tr></tfoot></table>";
    
    
            }
        }

        elseif ($sradio == "generic") {


            if ($keyword == '') {

                $query = "SELECT * FROM components LIMIT 25";

                } else {

                $query = "SELECT * FROM components WHERE cname LIKE '%$keyword%' LIMIT 25";
            }

            $result  = mysqli_query($db, $query);

            if (mysqli_num_rows($result) == 0) {
        
                echo "<table border='1' class='greenTable'><tfoot><tr><td colspan=5>No Results Found!</td></tr></tfoot></table>";

            } else {

            echo 
            " <table border='1' class='greenTable table-hover'>
            <thead>
                <tr>
                    <th>#ID</th>
                    <th>Generic Drug</th>
                </tr>
            </thead>
            <tbody>";
    

            while ($row = mysqli_fetch_array($result))
            {
                $cid = $row['C_ID'];
                echo "<tr class='clickable-row' data-href='drug-info.php?cid=$cid' style='cursor:pointer'>";
                echo "<td>" . $row['C_ID'] . "</td>";
                echo "<td>" . $row['cname'] . "</td>";
                echo "</tr>";

            }

             echo "</tbody><tfoot><tr><td colspan=5>Displaying Top 25 Searches!</td></tr></tfoot></table>";
    
            }
        } elseif ($sradio == "pharm") {
            
            if ($keyword == '') {

                $query = "SELECT * FROM user WHERE type='reseller' LIMIT 25";

                } else {

                $query = "SELECT * FROM user WHERE type='reseller' AND CAST(PIN as char(7)) LIKE '%$keyword%' LIMIT 25";
            }

            $result  = mysqli_query($db, $query);

            if (mysqli_num_rows($result) == 0) {
        
                echo "<table border='1' class='greenTable'><tfoot><tr><td colspan=5>No Results Found!</td></tr></tfoot></table>";

            } else {

                echo 
            " <table border='1' class='greenTable table-hover'>
            <thead>
                <tr>
                    <th>#ID</th>
                    <th>Email</th>
                    <th>Name</th>
                    <th>Phone No.</th>
                    <th>Location</th>
                    <th>PIN</th>
                </tr>
            </thead>
            <tbody>";
    

            while ($row = mysqli_fetch_array($result))
            {
                echo "<tr>";
                echo "<td>" . $row['U_ID'] . "</td>";
                echo "<td>" . $row['email'] . "</td>";
                echo "<td>" . $row['first_name'] . "</td>";
                echo "<td>" . $row['phone_no'] . "</td>";
                echo "<td>" . $row['house_no'] . "</td>";
                echo "<td>" . $row['PIN'] . "</td>";
                echo "</tr>";

            }

             echo "</tbody><tfoot><tr><td colspan=6>Displaying Top 25 Searches!</td></tr></tfoot></table>";
            }
            

        }
    }


    mysqli_close($db);
?>


</body>
</html>

