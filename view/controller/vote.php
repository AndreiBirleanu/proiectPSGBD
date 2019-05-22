<?php
if(isset($_GET['song'])){
    
    $song=$_GET['song'];
    $username=$_SESSION['username_id'];
    
    $mesaj;
    $query ="begin
    vote.vote_song(:piesa,:username,:v_message);
    end;";
     $s = oci_parse($c, $query);
    if (!$s) {
        $m = oci_error($c);
        trigger_error('Could not parse statement: '. $m['message'], E_USER_ERROR);
    }
    oci_bind_by_name($s,':piesa',$_GET['song'],32);
    oci_bind_by_name($s,':username',$username,32);
    
    oci_bind_by_name($s,':v_message',$mesaj,32);
    $r = oci_execute($s);
    if (!$r) {
        $m = oci_error($s);
        trigger_error('Could not execute statement: '. $m['message'], E_USER_ERROR);
    }
    
    
    if($mesaj == 'piesa votata'){
        header("Location: top.php");
        die();
    }else{
        if($mesaj == 'poti vota doar o singura data'){
           // echo "<script type='text/javascript'>alert('$mesaj');</script>";
        }else{
        header("Location: top.php?action=voteDennied");
        die();
        }
    }

 }

 ?>