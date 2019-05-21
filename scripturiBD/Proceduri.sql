CREATE OR REPLACE PACKAGE BODY top AS 
 
  PROCEDURE paginare(v_first int, v_much int)
  is
  v_sql varchar2(256);
  begin
  v_sql := 'CREATE OR REPLACE VIEW view_2 AS
    select * from songs order by voturi desc offset '|| v_first || ' rows fetch next ' || v_much || ' rows only';
    EXECUTE IMMEDIATE v_sql;
  end paginare;
  
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




CREATE OR REPLACE PACKAGE BODY song AS
    PROCEDURE addArtist(v_nume IN varchar2, v_artist IN varchar2)
    is
    idSong NUMBER;
    v_sql VARCHAR2(255);
    idArtist NUMBER;
    v_count number;
    BEGIN
        select count(*) into v_count from artists where nume_scena like v_nume;
        if(v_count >0) then
          Select songs_id into idSong from Songs where nume like v_nume;
        SELECT artists_id INTO idArtist from artists  where nume_scena like v_artist;
        v_sql:='INSERT INTO PROXYSONGARTIST(artists_fk, songs_fk, created_at, updated_at) VALUES (' || idArtist || ', ' || idSong ||', sysdate, sysdate)';
        EXECUTE IMMEDIATE v_sql;  
        else    
        INSERT INTO ARTISTS values(ART_SEQ.nextval,v_artist,sysdate,sysdate);
        Select songs.songs_id into idSong from Songs where nume like v_nume;
        SELECT artists_id INTO idArtist from artists  where nume_scena like v_artist;
        v_sql:='INSERT INTO PROXYSONGARTIST(artists_fk, songs_fk, created_at, updated_at) VALUES (' || idArtist || ', ' || idSong ||', sysdate, sysdate)';
        EXECUTE IMMEDIATE v_sql;  
       
        end if;
        
        
    end addArtist;
    
    PROCEDURE addGenre(v_nume IN varchar2, v_genre IN varchar2)
    is
    idSong NUMBER;
    v_sql VARCHAR2(255);
    idGenre NUMBER;
    v_count number;
    BEGIN
        select count(*) into v_count from genres where nume like v_nume;
        if(v_count >0) then
          Select songs_id into idSong from Songs where nume like v_nume;
        SELECT genres_id INTO idGenre from genres  where nume like v_genre;
        v_sql:='INSERT INTO PROXYSONGGENRE(songs_fk, genres_fk, created_at, updated_at) VALUES (' || idSong || ', ' || idGenre ||', sysdate, sysdate)';
        EXECUTE IMMEDIATE v_sql;  
        else    
        INSERT INTO GENRES values(gen_seq.nextval,v_genre,sysdate,sysdate);
        Select songs_id into idSong from Songs where nume like v_nume;
        SELECT genres_id INTO idGenre from genres  where nume like v_genre;
        v_sql:='INSERT INTO PROXYSONGGENRE(songs_fk, genres_fk, created_at, updated_at) VALUES (' || idSong || ', ' || idGenre ||', sysdate, sysdate)';
        EXECUTE IMMEDIATE v_sql;  
       
        end if;
        
        
    end addGenre;
    PROCEDURE addSong(v_user IN number,v_titlu IN varchar2, v_descriere IN varchar2, v_link IN varchar2, artistArray IN vay, genresArray IN vay, message OUT varchar2)
   is
   v_count number;
   v_sql VARCHAR2(255);
   begin
        select count(*) into v_count from songs where nume like v_titlu;
        if v_count > 0 then
        message:='Piesa este deja introdusa in aplicatie';
        return;
        end if;
        if v_link not like '%youtube%' then
        message:='Linkul nu este unul catre youtube';
        return;
        end if;
        INSERT INTO SONGS(nume,descriere,link_youtube,voturi,useri_fk,created_at,updated_at) values (v_titlu,v_descriere,v_link,0,v_user,sysdate,sysdate);
        
        FOR i IN 1..artistarray.count LOOP
            addArtist(v_titlu,artistarray(i));
          END LOOP;
          FOR i IN 1..genresarray.count LOOP
            addGenre(v_titlu,genresarray(i));
          END LOOP;
    message:='piesa adaugata cu succes';
   end addSong;
   

    
END song;