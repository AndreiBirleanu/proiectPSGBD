<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <title>TopMusic | Homepage</title>
    <link href="./css/bootstrap.min.css" rel="stylesheet">
    <link href="css/homepage.css" rel="stylesheet">

</head>

<body>

<!-- Navigation -->
<?php
include 'controller/nav.php';
require_once("db/dbconn.php");
           
require_once("controller/vote.php");
?>
<!-- Page Content -->
<div class="container">

    <header class="jumbotron">
        <h1 class="display-2">Latest Top Music!</h1>
        <p class="lead">Find out on what place in our tops you find your favorite songs, vote them and bring them to #1!</p>
        <a href="top.php" class="btn btn-black">See this week's top!</a>
    </header>

    <!-- Page Features -->
    <div class="row text-center">
        <?php 
            
            $query = "SELECT songs_id as id,nume as nume,descriere as descc FROM view_2  where rownum<4";
 
           // $query2 = "SELECT a.nume_scena FROM view_2 v inner join proxysongartist on v.songs_id=psa.songs_fk inner join artists a on a.artists_id  = psa.artists_fk  where rownum<4";
 
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
            $i=0;
            while(($row = oci_fetch_array($s, OCI_ASSOC+OCI_RETURN_NULLS)) != false){
                $i=$i+1;
                //echo $row['ID'];
                $query2 = "SELECT a.nume_scena  FROM view_2 v inner join proxysongartist psa on v.songs_id=psa.songs_fk inner join artists a on a.artists_id  = psa.artists_fk  where v.songs_id=" . $row['ID'];
                
                $v = oci_parse($c, $query2);
                if (!$v) {
                    $m = oci_error($c);
                    trigger_error('Could not parse statement: '. $m['message'], E_USER_ERROR);
                }
                $r2 = oci_execute($v);
                if (!$r2) {
                    $m = oci_error($s);
                    trigger_error('Could not execute statement: '. $m['message'], E_USER_ERROR);
                }
                $artists='';
                while(($row2 = oci_fetch_array($v, OCI_ASSOC+OCI_RETURN_NULLS)) != false){
                    foreach ($row2 as $item) {
        
                        
                            $artists=$artists .',' . $item!==null?htmlspecialchars($item, ENT_QUOTES|ENT_SUBSTITUTE):"&nbsp;";
                           //echo '<h1>' .htmlspecialchars($item, ENT_QUOTES|ENT_SUBSTITUTE). '</h1>';
                        
                        
                        }
                    }
                

                echo '<div class="col-lg-3 col-md-6 mb-4">';
                    echo '<div class="card h-100">';
                        echo '<img class="card-img-top" src="./img/'. $i .'.png" alt="">';
                        echo '<div class="card-body">';
                            echo '<h4 class="card-title">'. $row['NUME'] .'</h4>';
                            echo '<h5 class="card-subtitle">by'. $artists .'</h5>';
                            echo '<p class="card-text">'. $row['DESCC'] .'</p></div>';
                        echo '<div class="card-footer">';
                        echo    "<a href='top.php?song=". $row['ID'] ."' class='btn btn-primary'>Upvote</a>";
                        echo '</div>
                        </div>
                    </div>';



            }
        
        ?>
       
        <div class="col-lg-3 col-md-6 mb-4">
            <div class="card h-100">
                <img class="card-img-top" src="./img/more.png" alt="">
                <div class="card-body">
                    <h4 class="card-title">More</h4>
                    <p class="card-text">See the full top and upvote or add your favorite songs.</p>
                </div>
                <div class="card-footer">
                    <a href="top.php" class="btn btn-primary">See more</a>
                </div>
            </div>
        </div>

    </div>
    <!-- /.row -->

</div>
<!-- /.container -->


<footer class="container-fluid text-center">
    <p>&copy; TopMusic App by Andrei-Cristian Bîrleanu & Laura Velicescu</p>
</footer>

<!-- Bootstrap core JavaScript -->
<script src="./jquery/jquery.min.js"></script>
<script src="./js/bootstrap.bundle.min.js"></script>

</body>

</html>
