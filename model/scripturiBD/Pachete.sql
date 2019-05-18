CREATE OR REPLACE PACKAGE user_registration AS
FUNCTION login(c_username useri.username%TYPE, c_password useri.username%TYPE) return number;
PROCEDURE register_user(c_username useri.username%TYPE,c_password useri.username%TYPE, c_admin useri.eadmin%TYPE,c_mesaj  OUT useri.username%TYPE);
END user_registration;

CREATE OR REPLACE PACKAGE crypto AS
FUNCTION crypting_pass(c_pass useri.username%TYPE) RETURN RAW;
END crypto;