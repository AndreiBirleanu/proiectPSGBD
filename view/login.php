
<?php

$error=0;
if(isset($_GET['action']) && $_GET['action']== 'login'){
require_once("db/dbconn.php");
$query = "select USER_REGISTRATION.LOGIN(:usern,:pass) as response from dual";
$s = oci_parse($c, $query);
if (!$s) {
    $m = oci_error($c);
    trigger_error('Could not parse statement: '. $m['message'], E_USER_ERROR);
}
oci_bind_by_name($s,':usern',$_POST['username'],32);
oci_bind_by_name($s,':pass',$_POST['password'],32);
$r = oci_execute($s);
if (!$r) {
    $m = oci_error($s);
    trigger_error('Could not execute statement: '. $m['message'], E_USER_ERROR);
}
 
$row = oci_fetch_array($s, OCI_ASSOC+OCI_RETURN_NULLS);
echo $row['RESPONSE'];
if($row['RESPONSE'] <1){
    $error=1;
}else{
    session_start();
    $_SESSION['username'] = $_POST['username'];
    
    $_SESSION['username_id'] = $row['RESPONSE'];
    header("Location: top.php");
    die();

}
}



?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
    <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
    <script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
    <link rel="stylesheet" href="css/login.css">
    <title>TopMusic | Login</title>
    
</head>

<body>
    
<div class="sidenav">
    <div class="login-main-text">
        <h2>Login to your TopMusic account.</h2>
        <p>Or register to join the TopMusic community.</p>
        <button onclick="window.location.href='./adminlogin.html'" class="btn btn-black">Login as an admin</button>
    </div>
</div>
<div class="main">
    <div class="col-md-6 col-sm-12">
        <div class="login-form">
            <form id = "loginForm" method="post" action = "login.php?action=login" >
             <?php if ($error ==1 )
             echo "<p>Username sau parola gresita</p>";
             ?>   
              
                <div class="form-group">
                    <label>Username</label>
                    <input type="text" class="form-control" id ="username" name = "username" placeholder="Username">
                </div>
                <div class="form-group">
                    <label>Password</label>
                    <input type="password" class="form-control" id= "password" name = "password" placeholder="Password">
                </div>
                <button type="submit" class="btn btn-black" id="login">Login</button>
                <button type="submit" class="btn btn-secondary">Register</button>
                
            </form>
            
        </div>
    </div>
</div>
</body>
</html>