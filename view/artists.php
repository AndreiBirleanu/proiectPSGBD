<?php
require_once("db/dbconn.php");

?>


<!DOCTYPE html>
<html>
<head>

        <meta charset="utf-16">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">
        <title>TopMusic | Homepage</title>
        <link href="./css/bootstrap.min.css" rel="stylesheet">
        <link href="css/top.css" rel="stylesheet">
<style>
* {box-sizing: border-box}
body {font-family: "Lato", sans-serif;}

/* Style the tab */
.tab {
  float: left;
  border: 1px solid #ccc;
  background-color: #f1f1f1;
  width: 30%;
  height: 300px;
}

/* Style the buttons inside the tab */
.tab button {
  display: block;
  background-color: inherit;
  color: black;
  padding: 22px 16px;
  width: 100%;
  border: none;
  outline: none;
  text-align: left;
  cursor: pointer;
  transition: 0.3s;
  font-size: 17px;
}

/* Change background color of buttons on hover */
.tab button:hover {
  background-color: #ddd;
}

/* Create an active/current "tab button" class */
.tab button.active {
  background-color: #ccc;
}

/* Style the tab content */
.tabcontent {
  float: left;
  padding: 0px 12px;
  border: 1px solid #ccc;
  width: 70%;
  border-left: none;
  height: 300px;
}
</style>
</head>
<body>
<?php
include 'controller/nav.php';
?>
<h2>Topuri pentru Genuri  TOP 9</h2>
<p>Selectati unul din genurile de mai jos</p>

<div class="tab">

  <?php
    //$query = "select * from(select g.nume FROM genres g inner join proxysonggenre psg on g.genres_id = psg.genres_fk inner join songs s on s.songs_id= psg.songs_fk where REGEXP_LIKE(g.nume, '[^A-Za-z]')  group by g.nume order by sum(voturi) desc ) where rownum <10";
    $query = "select * from top_artists_view";
   
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
    $control=0; 
    while (($row = oci_fetch_array($s, OCI_ASSOC+OCI_RETURN_NULLS)) != false) {
        
        $control=$control+1;
        foreach ($row as $item) {
            if($control==1)
            echo '<button class = "tablinks" onclick="openGenre(event, \''. htmlspecialchars($item, ENT_QUOTES|ENT_SUBSTITUTE).'\')" id="defaultOpen"><span>'. $control . '  </span>' . htmlspecialchars($item, ENT_QUOTES|ENT_SUBSTITUTE) .'</button>';
            else
            echo '<button class = "tablinks" onclick="openGenre(event, \''. htmlspecialchars($item, ENT_QUOTES|ENT_SUBSTITUTE).'\')" ><span>'. $control . '  </span>'. htmlspecialchars($item, ENT_QUOTES|ENT_SUBSTITUTE) .'</button>';
            
        }
        
    
       
    }
  
    ?>
<!--   
  <button class="tablinks" onclick="openCity(event, 'Paris')">Blues</button>
  <button class="tablinks" onclick="openCity(event, 'Tokyo')">Dance</button> -->
</div>
<?php 
//$query = "select * from(select a.nume_scena FROM artists a inner join proxysongartist psa on a.artists_id = psa.artists_id inner join songs s on s.songs_id= psa.songs_fk where REGEXP_LIKE(g.nume, '[^A-Za-z]')  group by g.nume order by sum(voturi) desc ) where rownum <10";
$query = "select * from top_artists_view";
   
   
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

while (($row = oci_fetch_array($s, OCI_ASSOC+OCI_RETURN_NULLS)) != false) {
        
      
    foreach ($row as $item) {
        
       // echo '<button class = "tablinks" onclick="openGenre(event, \''. htmlspecialchars($item, ENT_QUOTES|ENT_SUBSTITUTE).'\')" >' . htmlspecialchars($item, ENT_QUOTES|ENT_SUBSTITUTE) .'</button>';
       echo "<script> console.log('" . htmlspecialchars($item, ENT_QUOTES|ENT_SUBSTITUTE) . "');</script>";
        
       echo "<div id ='" . htmlspecialchars($item, ENT_QUOTES|ENT_SUBSTITUTE) . "' class = 'tabcontent'>\n";
       $query2 = "SELECT s.nume,s.descriere,s.link_youtube,s.voturi FROM  artists a inner join proxysongartist psa on a.artists_id = psa.artists_fk inner join songs s on s.songs_id= psa.songs_fk where a.nume_scena like '" . htmlspecialchars($item, ENT_QUOTES|ENT_SUBSTITUTE) .  "' order by voturi desc ";
        
       $x = oci_parse($c, $query2);
       if (!$x) {
        $m = oci_error($c);
        trigger_error('Could not parse statement: '. $m['message'], E_USER_ERROR);
    }
    $q = oci_execute($x);
            if (!$q) {
                $m = oci_error($s);
                trigger_error('Could not execute statement: '. $m['message'], E_USER_ERROR);
            }
            echo "<table id='tablePreview' class='table table-striped table-hover table-borderless'>";
            echo "<thead>";
            $ncols1 = oci_num_fields($x);
            echo "<tr>\n";
            echo "<th> # </th>";
            for ($j = 1; $j <= $ncols1; ++$j) {
                $colname = oci_field_name($x, $j);
                echo "<th>".htmlspecialchars($colname,ENT_QUOTES|ENT_SUBSTITUTE)."</th>\n";
            }
            echo "</tr>\n";
            echo "</thead>";
            $y =0;
            while (($row1 = oci_fetch_array($x, OCI_ASSOC+OCI_RETURN_NULLS)) != false) {
                $y=$y+1;
                echo "<tr>\n";
                echo "<th scope='row'>" . $y . "</th>";
                $count=0;
                foreach ($row1 as $item1) {
                    $count =$count+1;
                    if($count==3){
                        echo "<td><a href='";
                    echo $item1!==null?htmlspecialchars($item1, ENT_QUOTES|ENT_SUBSTITUTE):"&nbsp;";
                    echo "'>";
                    echo $item1!==null?htmlspecialchars($item1, ENT_QUOTES|ENT_SUBSTITUTE):"&nbsp;";
                    echo "</a>";
                    
                    echo "</td>\n";
                    }else{
                        if($count==1){
                            echo "<td><a href='about.php?name=";
                    echo $item1!==null?htmlspecialchars($item1, ENT_QUOTES|ENT_SUBSTITUTE):"&nbsp;";
                    echo "'style='color:lightgray;text-decoration:none;'>";
                    echo $item1!==null?htmlspecialchars($item1, ENT_QUOTES|ENT_SUBSTITUTE):"&nbsp;";
                    echo "</a>";
                    
                    echo "</td>\n";
                        }else{
                    echo "<td>";
                    echo $item1!==null?htmlspecialchars($item1, ENT_QUOTES|ENT_SUBSTITUTE):"&nbsp;";
                    echo "</td>\n";
                }
            }
                }
                echo    "<td><button class='btn btn-black'>Upvote</button></td>";

                echo "</tr>\n";
            }
            echo "</table>\n";

       echo "</div>";
            
            
    }
    

   
}

while (($row = oci_fetch_array($x, OCI_ASSOC+OCI_RETURN_NULLS)) != false) {
    
    
    foreach ($row as $item) {
        
        echo "<div id ='" . htmlspecialchars($item, ENT_QUOTES|ENT_SUBSTITUTE) . "' class = 'tabcontent'>\n";
        echo "<script> console.log('" . htmlspecialchars($item, ENT_QUOTES|ENT_SUBSTITUTE) . "');</script>";
        $query = "SELECT s.nume,s.descriere,s.voturi FROM  genres g inner join proxysonggenre psg on g.genres_id = psg.genres_fk inner join songs s on s.songs_id= psg.songs_fk where g.nume like '" . htmlspecialchars($item, ENT_QUOTES|ENT_SUBSTITUTE) .  "' order by voturi desc ";
            
            echo $query;
            
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
            echo "<table id='tablePreview' class='table table-striped table-hover table-borderless' >";
            echo "<thead>";
            $ncols = oci_num_fields($s);
            echo "<tr>\n";
            echo "<th> # </th>";
            for ($i = 1; $i <= $ncols; ++$i) {
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
                foreach ($row as $item) {
                    echo "<td>";
                    echo $item!==null?htmlspecialchars($item, ENT_QUOTES|ENT_SUBSTITUTE):"&nbsp;";
                    echo "</td>\n";
                }
                echo    "<td><button class='btn btn-black'>Upvote</button></td>";

                echo "</tr>\n";
            }
            echo "</table>\n";
            echo "</div>";
        
    }
    

   
}


?>
<!-- <div id="London" class="tabcontent">
        
</div>

<div id="Paris" class="tabcontent">
  <h3>Paris</h3>
  <p>Paris is the capital of France.</p> 
</div>

<div id="Tokyo" class="tabcontent">
  <h3>Tokyo</h3>
  <p>Tokyo is the capital of Japan.</p>
</div> -->

<script>
function openGenre(evt, cityName) {
  var i, tabcontent, tablinks;
  tabcontent = document.getElementsByClassName("tabcontent");
  for (i = 0; i < tabcontent.length; i++) {
    tabcontent[i].style.display = "none";
  }
  tablinks = document.getElementsByClassName("tablinks");
  for (i = 0; i < tablinks.length; i++) {
    tablinks[i].className = tablinks[i].className.replace(" active", "");
  }
  document.getElementById(cityName).style.display = "block";
  evt.currentTarget.className += " active";
}

// Get the element with id="defaultOpen" and click on it
document.getElementById("defaultOpen").click();
</script>
   
</body>
</html> 
