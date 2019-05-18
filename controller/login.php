<?php
include_once '../model/databaseConnection.php';
include_once '../view/login.html';
session_start();

$query = "SELECT username FROM useri WHERE username=:username AND pass=:password;";




