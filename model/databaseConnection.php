<?php
error_reporting(E_ALL);
ini_set('display_errors', 'On');

$username = "proiect";
$password = "proiect";
$database = "localhost/XE";

$conn = oci_connect($username, $password, $database);
if (!$conn) {
    $e = oci_error();
    trigger_error(htmlentities($e['message'], ENT_QUOTES), E_USER_ERROR);
}
