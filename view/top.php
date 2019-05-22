<?php
 require_once("db/dbconn.php");

 require_once("controller/pagination.php");
 
 require_once("controller/vote.php");
 require_once("controller/session.php");
error_reporting(E_ALL);
ini_set('display_errors', 'On');
 
$username = "C##PROIECT";                  // Use your username
$password = "PROIECT";             // and your password
$database = "localhost:1522/XE";   // and the connect string to connect to your database
$current_url = $_SERVER['PHP_SELF'];

?>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>TopMusic | Homepage</title>
    <link href="./css/bootstrap.min.css" rel="stylesheet">
    <link href="css/top.css" rel="stylesheet">

</head>
<body>
<?php
include 'controller/nav.php';
?>
<div class="container">
<header class="jumbotron">
    <div class="float-right">
        <h1 class="display-2">Latest Music Top!</h1>
        <p class="lead">Top 10 for 22-28 April 2019 </p>
        <a href="#" class="btn btn-black">See last week's top 10!</a>
    </div>
</header>
<a href="top.php">TOP 10</a>  
  <a href="top.php?page=2">TOP 20</a>
  <a href="top.php?page=3">TOP 30</a>
  <a href="top.php?page=5">TOP 50</a>
  <a href="top.php?page=10">TOP 100</a>
  <a href="top.php?page=20">TOP 200</a>
  <a href="top.php?page=100">TOP 1000</a>  
<?php
if(isset($_GET['action']) && $_GET['action'] == 'voteDennied'){
    echo "<h3>Acces restrictionat la votare</h3>";
}
$query = "SELECT songs_id,nume as nume,descriere,link_youtube,voturi FROM view_2  ";
 

 
$s = oci_parse($c, $query);
if (!$s) {
    $m = oci_error($c);
    trigger_error('Could not parse statement: '. $m['message'], E_USER_ERROR);
}
$r = oci_execute($s);
if (!$r) {
    $m = oci_error($s);
    trigger_error('Could not execute statement: '. $m['message'], E_USER_ERROR);
}
 echo "<table id='tablePreview' class='table table-striped table-hover table-borderless'>";
 echo "<thead>";
$ncols = oci_num_fields($s);
echo "<tr>\n";
echo "<th> # </th>";
for ($i = 2; $i <= $ncols; ++$i) {
    $colname = oci_field_name($s, $i);
    echo "<th>".htmlspecialchars($colname,ENT_QUOTES|ENT_SUBSTITUTE)."</th>\n";
}
echo "</tr>\n";
echo "</thead>";
$i =0;
while (($row = oci_fetch_array($s, OCI_ASSOC+OCI_RETURN_NULLS)) != false) {
    $i=$i+1;
    echo "<tr>\n";
    echo "<th scope='row'>" . $i . "</th>";
    $cont=0;
    $piesa="";
    foreach ($row as $item) {
        
        if($cont ==0){
            $piesa=$item!==null?htmlspecialchars($item, ENT_QUOTES|ENT_SUBSTITUTE):"&nbsp;";
            $cont=$cont+1;
        }else{
        $cont=$cont+1;
        echo "<td>";
        
        echo $item!==null?htmlspecialchars($item, ENT_QUOTES|ENT_SUBSTITUTE):"&nbsp;";
        echo "</td>\n";
        }
    }
    
    echo    "<td><form method='post' action='top.php?song=". $piesa ."'><button class='btn btn-black' >Upvote</button></form></td>";

    echo "</tr>\n";
}
echo "</table>\n";



?>

  
  <a href="top.php">TOP 10</a>  
  <a href="top.php?page=2">TOP 20</a>
  <a href="top.php?page=3">TOP 30</a>
  <a href="top.php?page=5">TOP 50</a>
  <a href="top.php?page=10">TOP 100</a>
  <a href="top.php?page=20">TOP 200</a>
  <a href="top.php?page=100">TOP 1000</a> 
  
</div>

<footer class="container-fluid text-center">
    <p>&copy; TopMusic App by Andrei-Cristian Bîrleanu & Laura Velicescu</p>
</footer>

<!-- Bootstrap core JavaScript -->
<script src="./jquery/jquery.min.js"></script>
<script src="./js/bootstrap.bundle.min.js"></script>

</body>
</html>