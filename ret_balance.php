<?php
    include ('session.php');
    
    $total = ($_POST['total']);
 
 	$uid = $_SESSION['login_id'];

    $query = "SELECT walletamt FROM user WHERE U_ID = $uid;";
    $result  = mysqli_query($db, $query);
    $row = mysqli_fetch_array($result);
    $var = $row['walletamt'];

    if ($var < $total) {
    	echo "<b> Insufficient Wallet Amount! </b>";
    } else {
    	$ans = $var - $total;
    	echo "<b> Your Wallet Amount is now : &#8377; ".$ans."</b>";
    	$query = "UPDATE user SET walletamt = $ans WHERE U_ID = $uid";
   	    $result  = mysqli_query($db, $query);
    }
?>