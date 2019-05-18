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



select crypto.CRYPTING_PASS('viata e frumoasa') from dual;
desc useri;
select * from useri;

DECLARE
v_mesaj varchar2(255);
BEGIN 
USER_REGISTRATION.REGISTER_USER('ADMINISTRATOR231', 'ADMINISTRATOR', 1, v_mesaj); 
dbms_output.put_line(v_mesaj);
END;

select USER_REGISTRATION.LOGIN('ADMINISTRATOR','ADMINISTRATOR') from dual;