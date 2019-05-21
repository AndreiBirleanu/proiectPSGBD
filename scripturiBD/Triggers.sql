CREATE OR REPLACE TRIGGER check_genre_name
BEFORE INSERT
on genres
FOR EACH ROW
DECLARE
v_nume varchar2(255);
BEGIN
dbms_output.put_line(:old.nume);
select replace(:old.nume,'''', '') into v_nume from dual;

:new.nume:=v_nume;
dbms_output.put_line(:new.nume);
END;

CREATE OR REPLACE TRIGGER auto_inc_users
BEFORE INSERT ON useri
FOR EACH ROW

BEGIN
  SELECT usr_seq.NEXTVAL
  INTO   :new.useri_id
  FROM   dual;
  DBMS_OUTPUT.PUT_LINE(:new.useri_id);
END;


CREATE OR REPLACE TRIGGER auto_inc_artists 
BEFORE INSERT ON artists
FOR EACH ROW
BEGIN
  SELECT ART_SEQ.nextval
  INTO   :new.artists_id
  FROM   dual;
END;

CREATE OR REPLACE TRIGGER auto_inc_songs
BEFORE INSERT ON songs
FOR EACH ROW
BEGIN
  SELECT songs_seq.NEXTVAL
  INTO   :new.songs_id
  FROM   dual;
END;


CREATE OR REPLACE TRIGGER auto_inc_comm
BEFORE INSERT ON comments
FOR EACH ROW
BEGIN
  SELECT comm_seq.NEXTVAL
  INTO   :new.comments_id
  FROM   dual;
END;


CREATE OR REPLACE TRIGGER auto_inc_genres 
BEFORE INSERT ON genres
FOR EACH ROW
BEGIN
  SELECT gen_seq.NEXTVAL
  INTO   :new.genres_id
  FROM   dual;
END;
