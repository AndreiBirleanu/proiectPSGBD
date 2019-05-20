CREATE OR REPLACE PACKAGE BODY crypto AS  
   
   -----------------------------------------------------------------------
  --Encrypt a password 
  --Salt the password
  ------------------------------------------------------------------------
  FUNCTION crypting_pass(c_pass useri.username%TYPE) RETURN RAW
  IS
        G_CHARACTER_SET VARCHAR2(10) := 'AL32UTF8';
    G_STRING VARCHAR2(32) := '12345678901234567890123456789012';
    G_KEY RAW(250) := utl_i18n.string_to_raw
                        ( data => G_STRING,
                          dst_charset => G_CHARACTER_SET );
    G_ENCRYPTION_TYPE PLS_INTEGER := dbms_crypto.encrypt_aes256 
                                      + dbms_crypto.chain_cbc 
                                      + dbms_crypto.pad_pkcs5;

    l_val RAW(32) := UTL_I18N.STRING_TO_RAW( c_pass, G_CHARACTER_SET );
    l_encrypted RAW(32);
  BEGIN
    l_val := utl_i18n.string_to_raw
              ( data => c_pass,
                dst_charset => G_CHARACTER_SET );

    l_encrypted := dbms_crypto.encrypt
                   ( src => l_val,
                     typ => G_ENCRYPTION_TYPE,
                     key => G_KEY );

    RETURN l_encrypted;
  END crypting_pass;
END crypto; 

CREATE OR REPLACE PACKAGE BODY user_registration AS 
    FUNCTION login(c_username useri.username%TYPE, c_password useri.username%TYPE) return number
    IS
    match_count number;
    encrypted_pass raw(100);
    begin
    select crypto.crypting_pass(c_password) into encrypted_pass from dual;
    select count(*)
    into match_count
    from useri
    where username like c_username
    and pass like encrypted_pass;
  if match_count = 0 then
    return 0;
  elsif match_count = 1 then
    return 1;
  else
    return -1;
  end if;
end login;
  PROCEDURE register_user(c_username useri.username%TYPE,c_password useri.username%TYPE, c_admin useri.eadmin%TYPE, c_mesaj OUT useri.username%TYPE) 
  IS
    match_count number;
    encrypted_pass raw(100);
    c_raw raw(100);
    sql_stmt varchar2(255);
    begin
    select count(*) into match_count from useri where username like c_username;
    if( match_count >0 ) then
      c_mesaj :='Username deja existent';
      return;
    end if;
    if( length(c_password) not between 5 and 20 ) then
     c_mesaj:='Parola pea mica sau prea mare';
     return;
    end if;
    select CRYPTO.CRYPTING_PASS(c_password) into c_raw from dual;
    insert into useri values( usr_seq.nextval,c_username,c_raw,c_admin,0,sysdate,sysdate);
   c_mesaj:='User inregistrat';
end register_user;
END user_registration; 


CREATE OR REPLACE PACKAGE BODY vote AS 
    FUNCTION vote_song(v_piesa varchar2, v_user varchar2) return number
    IS
    v_canVote number;
    v_sql varchar2(255);
    begin
    select ebanat into v_canVote from useri where username like v_user;
  if v_canVote = 0 then
    return 0;
  end if;
  v_sql:='UPDATE songs SET voturi=voturi+1 where nume like "' || v_piesa || '"';
  execute IMMEDIATE v_sql;
end vote_song;

FUNCTION BAN(v_user varchar2) return number
is
v_sql varchar2(255);
v_canVote number;
begin

select ebanat into v_canVote from useri where username like v_user;
  if v_canVote = 1 then
    return 0;
  end if;
  
   v_sql:='UPDATE useri SET ebanat=1 where nume like "' || v_user || '"';
  execute IMMEDIATE v_sql;
  return 1;


end ban;
  
END vote; 



CREATE OR REPLACE PACKAGE BODY addSong AS
    FUNCTION addArtist(v_nume IN varchar2, v_artist IN varchar2)return NUMBER
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
        v_sql:='INSERT INTO PROXYSONGARTIST(artists_fk, songs_fk, created_at, updated_at) VALUES (' || idartist || ', ' || idsong ||', sysdate, sysdate)';
        EXECUTE IMMEDIATE v_sql;  
        else    
        INSERT INTO ARTISTS values(ART_SEQ.nextval,v_artist,sysdate,sysdate);
        Select songs.songs_id into idSong from Songs where nume like v_nume;
        SELECT artists_id INTO idArtist from artists  where nume_scena like v_artist;
        v_sql:='INSERT INTO PROXYSONGARTIST(artists_fk, songs_fk, created_at, updated_at) VALUES (' || idartist || ', ' || idsong ||', sysdate, sysdate)';
        EXECUTE IMMEDIATE v_sql;  
       
        end if;
        return 1;
        
    end addArtist;    
    END addSong;
