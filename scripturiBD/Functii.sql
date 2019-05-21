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
    FUNCTION login(c_username useri.username%TYPE, c_password useri.username%TYPE) return int
    IS
    match_count number;
    encrypted_pass raw(100);
    v_id int;
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
  select useri_id into v_id from useri where username like c_username;
    return v_id;
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
    PROCEDURE vote_song(v_piesa int, v_user int, v_message OUT varchar2) 
    IS
    v_canVote number;
    v_sql varchar2(255);
    v_count number;
    begin
    select ebanat into v_canVote from useri where useri_id = v_user;
  if v_canVote = 1 then
    v_message:=v_message ||'user banat';
    return;
  end if;
    select count(*) into v_count from votes where songs_fk = v_piesa and useri_fk=v_user;
  if v_count > 0 then
    v_message:='poti vota doar o singura data';
    return;
    end if;
    
  v_sql:='UPDATE songs SET voturi=voturi+1 where songs_id = ' || v_piesa ;
  insert into votes values (v_piesa, v_user);
 -- DBMS_OUTPUT.PUT_LINE(v_sql);
  execute IMMEDIATE v_sql;
  v_message:=v_message||'piesa votata';
end vote_song;

PROCEDURE BAN(v_user varchar2, v_message OUT varchar2)
is
v_sql varchar2(255);
v_canVote number;
begin

select ebanat into v_canVote from useri where username like v_user;
  if v_canVote = 1 then
    v_message:=v_message||'user deja banat';
    return;
  end if;
  
   v_sql:='UPDATE useri SET ebanat=1 where nume like "' || v_user || '"';
  execute IMMEDIATE v_sql;
  v_message:=v_message||'user banat';


end ban;
  
END vote; 



commit;

select user_registration.login('jerry','parola') from dual;


select * from votes;

 select * from asdfg;

