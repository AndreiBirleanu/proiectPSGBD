CREATE OR REPLACE PACKAGE user_registration AS
FUNCTION login(c_username useri.username%TYPE, c_password useri.username%TYPE) return number;
PROCEDURE register_user(c_username useri.username%TYPE,c_password useri.username%TYPE, c_admin useri.eadmin%TYPE,c_mesaj  OUT useri.username%TYPE);
END user_registration;

CREATE OR REPLACE PACKAGE crypto AS
FUNCTION crypting_pass(c_pass useri.username%TYPE) RETURN RAW;
END crypto;

CREATE OR REPLACE PACKAGE top as
PROCEDURE top_this_week;
--PROCEDURE top_last_week;
END top;


CREATE OR REPLACE PACKAGE create_view as
PROCEDURE top_genres;
FUNCTION top_by_name( v_name varchar2) return SYS_REFCURSOR;

END create_view;


CREATE OR REPLACE PACKAGE vote as 
FUNCTION vote_song( v_piesa varchar2, v_user varchar2  ) return number;
FUNCTION BAN(v_user varchar2) return number;
END vote;

CREATE OR REPLACE PACKAGE addSong as
TYPE vay IS ARRAY(20) OF varchar2(250);
--PROCEDURE addSong(v_titlu IN varchar2, v_descriere IN varchar2, v_link IN varchar2, artistArray IN vay, genresArray IN vay, message OUT varchar2);
FUNCTION addArtist(v_nume IN varchar2, v_artist IN varchar2)return NUMBER;
--FUNCTION addGenre(v_nume IN varchar2, v_genre IN varchar2) return NUMBER;
END addSong;


