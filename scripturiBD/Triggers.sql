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