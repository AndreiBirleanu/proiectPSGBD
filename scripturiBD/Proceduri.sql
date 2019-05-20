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



CREATE OR REPLACE PACKAGE BODY create_view AS
v_sql varchar2(1000);
PROCEDURE top_genres 
IS
BEGIN


  v_sql:= 'CREATE or REPLACE VIEW top_genre_view AS
  select * from
  (select g.nume FROM genres g inner join proxysonggenre psg on g.genres_id = psg.genres_fk inner join songs s on s.songs_id= psg.songs_fk   
  group by g.nume order by sum(voturi) desc ) where rownum <10';
  execute IMMEDIATE v_sql;
END top_genres;


FUNCTION top_by_name( v_name varchar2) return SYS_REFCURSOR

AS
my_cursor SYS_REFCURSOR;
begin

OPEN my_cursor FOR  SELECT s.nume,s.descriere,s.voturi 
FROM  genres g inner join proxysonggenre psg on g.genres_id = psg.genres_fk inner join songs s on s.songs_id= psg.songs_fk 
where g.nume like v_name order by voturi desc ;

 RETURN my_cursor;
    



end top_by_name;
end create_view;





begin
top.top_this_week;
end;

begin
create_view.top_genres;

end;

select * from genres;

select * from songs order by updated_at desc;

select create_view.top_by_name('Grunge') from dual;