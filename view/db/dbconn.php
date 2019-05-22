<?php
  session_start();
   echo $_SESSION['username'];
  
    error_reporting(E_ALL);
    ini_set('display_errors', 'On');
     
    $username = "C##PROIECT";                 
    $password = "PROIECT";             
    $database = "localhost:1522/XE";   
    
    
    $c = oci_connect($username, $password, $database);
    if (!$c) {
        $m = oci_error();
        trigger_error('Could not connect to database: '. $m['message'], E_USER_ERROR);
    }


?>