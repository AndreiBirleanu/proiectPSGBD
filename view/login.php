
<?php

$error=0;
if(isset($_GET['action']) && $_GET['action']== 'login'){
require_once("../model/databaseConnection.php");
$queryLogin = "select USER_REGISTRATION.LOGIN(:usern,:pass) as response from dual";
$s = oci_parse($conn, $queryLogin);
if (!$s) {
    $m = oci_error($conn);
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
if($row['RESPONSE'] !=1){
    $error=1;
}else{
    session_start();
    $_SESSION['username'] = $_POST['username'];
    header("Location: homepage.html");
    die();

}
}


if(isset($_GET['action']) && $_GET['action']=='register') {
    $v_mesaj = "";
    require_once("../model/databaseConnection.php");
    $queryRegister = "DECLARE v_mesaj VARCHAR(255);
                     BEGIN 
                     USER_REGISTRATION.REGISTER_USER(:username, :password, 0, :message);
                     dbms_output.put_line(v_mesaj);
                     END;";
    $t = oci_parse($conn, $queryRegister);
    if (!$t) {
        $m = oci_error($t);
        trigger_error('Could not parse statement: ' . $m['message'], E_USER_ERROR);
    }

    oci_bind_by_name($t, ':username', $_POST['username'], 32);
    oci_bind_by_name($t, ':password', $_POST['password'], 32);
    oci_bind_by_name($t, ':message', $v_mesaj, 32);
    $e = oci_execute($t);
    if (!$e) {
        $m = oci_error($t);
        trigger_error('Could not execute statement: ' . $m['message'], E_USER_ERROR);
    }


    if ($v_mesaj == "Username deja existent" ){
        $error = 2;
    }
    else if($v_mesaj == "Parola pea mica sau prea mare" ){
        $error = 3;
    }
    else if ($v_mesaj == "User inregistrat"){
            session_start();
            $_SESSION['username'] = $_POST['username'];
            header("Location: homepage.html");
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
            <form id = "loginForm" >
             <?php if ($error ==1 )
                echo "<p>Wrong username or password</p>";
             else if ($error == 2)
                echo "<p>This username already exists.</p>";
             else if ($error == 3)
                 echo "<p>The password is either too short or too long.</p>";
             ?>   
              
                <div class="form-group">
                    <label>Username</label>
                    <input type="text" class="form-control" id ="username" name = "username" placeholder="Username">
                </div>
                <div class="form-group">
                    <label>Password</label>
                    <input type="password" class="form-control" id= "password" name = "password" placeholder="Password">
                </div>
                <button type="submit" class="btn btn-black" id="login" formaction="login.php?action=login" formmethod="post">Login</button>
                <button type="submit" class="btn btn-secondary" id="register" formaction="login.php?action=register" formmethod="post">Register</button>
                
            </form>
            
        </div>
    </div>
</div>
</body>
</html>