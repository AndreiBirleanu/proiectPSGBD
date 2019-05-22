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
PROCEDURE top_artists 
IS
BEGIN


  v_sql:= 'CREATE or REPLACE VIEW top_artists_view AS
  select * from
  (select a.nume_scena FROM artists a inner join proxysongartist psa on a.artists_id = psa.artists_fk inner join songs s on s.songs_id= psa.songs_fk   
  group by a.nume_scena order by sum(voturi) desc ) where rownum <10';
  execute IMMEDIATE v_sql;
END top_artists;


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
    PROCEDURE addSong(v_user IN number,v_titlu IN varchar2, v_descriere IN varchar2, v_link IN varchar2, artistArray IN VARCHAR2, genresArray IN varchar2, message OUT varchar2)
   is
   v_count number;
   v_sql VARCHAR2(255);
   cursor c1 is
   select regexp_substr(artistArray,'[^,]+', 1, level) as a  from dual
    connect by regexp_substr(artistArray, '[^,]+', 1, level) is not null;
    cursor c2 is
    select regexp_substr(genresArray,'[^,]+', 1, level) as a  from dual
    connect by regexp_substr(genresArray, '[^,]+', 1, level) is not null;
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
        INSERT INTO SONGS(songs_id,nume,descriere,link_youtube,voturi,useri_fk,created_at,updated_at) values (SONGS_SEQ.nextval,v_titlu,v_descriere,v_link,0,v_user,sysdate,sysdate);
       
        FOR v_c1 in c1
        LOOP
        addArtist(v_titlu,v_c1.A);
        end loop;
        FOR v_c2 in c2
        LOOP
        addGenre(v_titlu,v_c2.A);
        end loop;
    message:='piesa adaugata cu succes';
   end addSong;
   

    
END song;

select * from genres order by genres_id desc;
select * from useri order by useri_id desc;
select * from songs order by songs_id desc;
select * from votes;

begin
create_view.top_artists;
end;