CREATE OR REPLACE PACKAGE BODY top AS 
 
    PROCEDURE top_this_week 
    IS
    curent_sys date;
    day varchar2(30);
    hours number;
    match_count number;
    encrypted_pass raw(100);
    begin
    select sysdate into curent_sys from dual;
    select lower(to_char(sysdate,'day')) into day from dual;
    
    select to_number(to_char(sysdate,'hh24')) into hours from dual;
    
    dbms_output.put_line(curent_sys);
    dbms_output.put_line(day);
    dbms_output.put_line(hours);
    if( trim(day
    

end top_this_week;
  
END top; 

begin
top.top_this_week;
end;


select * from songs order by updated_at desc;