
<?php

$error=0;
if(isset($_GET['action']) && $_GET['action']== 'addSong') {
    require_once("../model/databaseConnection.php");
    $queryAddSong = "";
    $s = oci_parse($conn, $queryAddSong);
    if (!$s) {
        $m = oci_error($conn);
        trigger_error('Could not parse statement: ' . $m['message'], E_USER_ERROR);
    }

    foreach (explode(',', $_POST['artists']) as $artist) {
        $artist = trim($artist);
        if (empty($artist)) {
            continue;
        }
    }
    foreach (explode(',', $_POST['genres']) as $genre) {
        $genre = trim($genre);
        if (empty($genre)) {
            continue;
        }
    }
    oci_bind_by_name($s, ':title', $_POST['songTitle'], 32);
    oci_bind_by_name($s, ':description', $_POST['description'], 32);
    oci_bind_by_name($s, ':linkYouTube', $_POST['linkYouTube'], 32);
    $r = oci_execute($s);

    if (!$r) {
        $m = oci_error($s);
        trigger_error('Could not execute statement: ' . $m['message'], E_USER_ERROR);
    }

    $row = oci_fetch_array($s, OCI_ASSOC + OCI_RETURN_NULLS);
    session_start();
    $_SESSION['username'] = $_POST['username'];
    header("Location: homepage.html");
    die();
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
    <title>TopMusic | Add a song</title>

</head>

<body>

<!--<div class="sidenav">-->
<!--    <div class="login-main-text">-->
<!--        <h2>Add your favorite song!</h2>-->
<!--        <p>People will be able to upvote and comment on it.</p>-->
<!---->
<!--    </div>-->
<!--</div>-->
<div class="main">
    <div class="col-md-6 col-sm-12">
        <div class="login-form">
            <form id = "addSongForm" >

                <div class="form-group">
                    <label>Title</label>
                    <input type="text" class="form-control" id ="songTitle" name = "songTitle" placeholder="Title">
                </div>
                <div class="form-group">
                    <label>Artists Names(separated by commas)/Band Name</label>
                    <input type="text" class="form-control" id= "artist" name = "artist" placeholder="Artist/Band">
                </div>
                <div class="form-group">
                    <label>Genres (separated by commas)</label>
                    <input type="text" class="form-control" id= "genre" name = "genre" placeholder="Genres">
                </div>
                <div class="form-group">
                    <label>Description</label>
                    <input type="text" class="form-control" id= "description" name = "description" placeholder="Description">
                </div>
                <div class="form-group">
                    <label>Description</label>
                    <input type="url" class="form-control" id= "linkYouTube" name = "linkYouTube" placeholder="https://www.youtube.com/">
                </div>
                <button type="submit" class="btn btn-black" id="addSong" formaction="addSong.php?action=addSong" formmethod="post">Add Song</button>
            </form>

        </div>
    </div>
</div>
</body>
</html>