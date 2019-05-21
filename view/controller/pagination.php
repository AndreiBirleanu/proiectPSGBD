 <?php
if(isset($_GET['page'])){
    $page=$_GET['page'] * 10;
    $username=$_SESSION['username_id'];
    $query ="begin
    top.paginare(1,:last);
    end;";
     $s = oci_parse($c, $query);
    if (!$s) {
        $m = oci_error($c);
        trigger_error('Could not parse statement: '. $m['message'], E_USER_ERROR);
    }
    oci_bind_by_name($s,':last',$page,32);
    
    $r = oci_execute($s);
    if (!$r) {
        $m = oci_error($s);
        trigger_error('Could not execute statement: '. $m['message'], E_USER_ERROR);
    }
    
    
    

 }else{
    $query ="begin
    top.paginare(1,10);
    end;";
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
 }

 ?> 