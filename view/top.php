<?php
 
error_reporting(E_ALL);
ini_set('display_errors', 'On');
 
$username = "proiect";                  // Use your username
$password = "proiect";             // and your password
$database = "localhost/XE";   // and the connect string to connect to your database
 

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
<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
    <div class="container">
        <a class="navbar-brand" href="#">TopMusic</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarResponsive">
            <ul class="navbar-nav ml-auto">
                <li class="nav-item">
                    <a class="nav-link" href="homepage.html">Home</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">About</a>
                </li>
                <li class="nav-item active">
                    <a class="nav-link" href="#">Tops</a>
                    <span class="sr-only">(current)</span>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">Genres</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">Artists</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">Profile</a>
                </li>
            </ul>
        </div>
    </div>
</nav>
<div class="container">
<header class="jumbotron">
    <div class="float-right">
        <h1 class="display-2">Latest Music Top!</h1>
        <p class="lead">Top 10 for 22-28 April 2019 </p>
        <a href="#" class="btn btn-black">See last week's top 10!</a>
    </div>
</header>
<?php
$query = "SELECT nume,descriere,voturi FROM songs order by voturi desc ";
 
$c = oci_connect($username, $password, $database);
if (!$c) {
    $m = oci_error();
    trigger_error('Could not connect to database: '. $m['message'], E_USER_ERROR);
}
 
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
?>

<!--Table-->
<!--
<table id="tablePreview" class="table table-striped table-hover table-borderless">
    
    <thead>
    <tr>
        <th>#</th>
        <th>Title</th>
        <th>Artists</th>
        <th>Genres</th>
        <th>Votes</th>
        <th>Actions</th>
    </tr>
    </thead>
    <tbody>
    <tr>
        <th scope="row">1</th>
        <td>I Mean It</td>
        <td>G-Eazy, Remo</td>
        <td>Rap</td>
        <td>123456</td>
        <td><button class="btn btn-black">Upvote</button></td>

    </tr>
    <tr>
        <th scope="row">2</th>
        <td>I Do</td>
        <td>Cardi B</td>
        <td>Rap</td>
        <td>10973</td>
        <td>
            <button class="btn btn-black">Upvote</button>
        </td>

    <tr>
        <th scope="row">3</th>
        <td>Jenny of Oldstones</td>
        <td>Florence + The Machine</td>
        <td>Folk</td>
        <td>967</td>
        <td>
            <button class="btn btn-black">Upvote</button>
        </td>
    </tr>
    <tr>
        <th scope="row">4</th>
        <td>3005</td>
        <td>Childish Gambino</td>
        <td>Hip-Hop, Rap</td>
        <td>690</td>
        <td><button class="btn btn-black">Upvote</button></td>

    </tr>
    <tr>
        <th scope="row">5</th>
        <td>Larry</td>
        <td>the Bird</td>
        <td>@twitter</td>
        <td>Mark</td>
        <td><button class="btn btn-black">Upvote</button></td>

    </tr>
    <tr>
        <th scope="row">6</th>
        <td>Larry</td>
        <td>the Bird</td>
        <td>@twitter</td>
        <td>Mark</td>
        <td><button class="btn btn-black">Upvote</button></td>
    </tr>
    <tr>
        <th scope="row">7</th>
        <td>Larry</td>
        <td>the Bird</td>
        <td>@twitter</td>
        <td>Mark</td>
        <td><button class="btn btn-black">Upvote</button></td>

    </tr>
    <tr>
        <th scope="row">8</th>
        <td>Larry</td>
        <td>the Bird</td>
        <td>@twitter</td>
        <td>Mark</td>
        <td><button class="btn btn-black">Upvote</button></td>

    </tr>
    <tr>
        <th scope="row">9</th>
        <td>Larry</td>
        <td>the Bird</td>
        <td>@twitter</td>
        <td>Mark</td>
        <td><button class="btn btn-black">Upvote</button></td>

    </tr>
    <tr>
        <th scope="row">10</th>
        <td>Larry</td>
        <td>the Bird</td>
        <td>@twitter</td>
        <td>Mark</td>
        <td><button class="btn btn-black">Upvote</button></td>

    </tr>
    </tbody>
    </table>
Table-->

</div>

<footer class="container-fluid text-center">
    <p>&copy; TopMusic App by Andrei-Cristian Bîrleanu & Laura Velicescu</p>
</footer>

<!-- Bootstrap core JavaScript -->
<script src="./jquery/jquery.min.js"></script>
<script src="./js/bootstrap.bundle.min.js"></script>

</body>
</html>