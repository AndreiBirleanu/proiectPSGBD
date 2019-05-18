set define off;
DROP TABLE ProxySongArtist;
DROP TABLE ProxySongGenre;
DROP TABLE ProxySongComment;
DROP TABLE songs;
DROP TABLE genres;
DROP TABLE artists;
drop table comments;
DROP TABLE useri;
DROP SEQUENCE usr_seq;
DROP SEQUENCE songs_seq;
DROP SEQUENCE art_seq;
DROP SEQUENCE gen_seq;
DROP SEQUENCE comm_seq;
DROP SEQUENCE proxys_c;
DROP SEQUENCE proxys_a;
DROP SEQUENCE proxys_g;

--construim tablele
CREATE TABLE useri (
  useri_Id INT NOT NULL,
  username VARCHAR2(30) NOT NULL,
  pass RAW(100) NOT NULL,
  eAdmin INT DEFAULT 0,
  eBanat INT DEFAULT 0,
  created_at DATE,
  updated_at DATE,
  CONSTRAINT usr_pk PRIMARY KEY (useri_Id)
);
CREATE SEQUENCE usr_seq START WITH 1;
CREATE TABLE songs (
  songs_Id INT NOT NULL,
  nume VARCHAR2(255),
  descriere VARCHAR2(512),
  link_youtube VARCHAR2(512),
  voturi INT DEFAULT 0,
  useri_fk INT NOT NULL,
  created_at DATE,
  updated_at DATE,
  CONSTRAINT songs_pk PRIMARY KEY (songs_Id),
  CONSTRAINT songs_useri_pk FOREIGN KEY (useri_fk) REFERENCES useri (useri_Id)
);
CREATE SEQUENCE songs_seq START WITH 1;

CREATE TABLE artists (
  artists_Id INT NOT NULL,
  nume VARCHAR2(30) NOT NULL,
  prenume VARCHAR2(30) NOT NULL,
  nume_scena VARCHAR2(30) NOT NULL,
  created_at DATE,
  updated_at DATE,
  CONSTRAINT artist_pk PRIMARY KEY (artists_Id)
);
CREATE SEQUENCE art_seq START WITH 1;
CREATE TABLE genres (
  genres_Id INT NOT NULL,
  nume VARCHAR2(512) NOT NULL,
  created_at DATE,
  updated_at DATE,
  CONSTRAINT genre_pk PRIMARY KEY (genres_Id)
);
CREATE SEQUENCE gen_seq START WITH 1;
CREATE TABLE comments (
  comments_Id INT NOT NULL,
  text VARCHAR2(512),
  users_fk INT NOT NULL,
  created_at DATE,
  updated_at DATE,
  CONSTRAINT comm_pk PRIMARY KEY (comments_Id),
  CONSTRAINT comments_user_fk FOREIGN KEY (users_fk) REFERENCES useri(useri_Id)
);
CREATE SEQUENCE comm_seq START WITH 1;
CREATE TABLE ProxySongArtist (
  artists_fk INT NOT NULL,
  songs_fk INT NOT NULL,
  created_at DATE,
  updated_at DATE,
  CONSTRAINT proxysongartist_artist_fk FOREIGN KEY (artists_fk) REFERENCES artists (artists_Id),
  CONSTRAINT proxysongartist_song_fk FOREIGN KEY (songs_fk) REFERENCES songs (songs_Id)
);
CREATE SEQUENCE proxys_a START WITH 1;

CREATE TABLE ProxySongGenre (
  songs_fk INT NOT NULL,
  genres_fk INT NOT NULL,
  created_at DATE,
  updated_at DATE,
  CONSTRAINT proxysonggenre_genre_fk FOREIGN KEY (genres_fk) REFERENCES genres (genres_Id),
  CONSTRAINT proxysongagenre_song_fk FOREIGN KEY (songs_fk) REFERENCES songs (songs_Id)
);
CREATE SEQUENCE proxys_g START WITH 1;
CREATE TABLE ProxySongComment (
  songs_fk INT NOT NULL,
  comments_fk INT NOT NULL,
  created_at DATE,
  updated_at DATE,
  CONSTRAINT proxysongcomment_comment_fk FOREIGN KEY (comments_fk) REFERENCES comments (comments_Id),
  CONSTRAINT proxysongcomment_song_fk FOREIGN KEY (songs_fk) REFERENCES songs (songs_Id)
);
CREATE SEQUENCE proxys_c START WITH 1;


SET SERVEROUTPUT ON;
--declaram nume si prenume pentru useri
DECLARE
  TYPE varr IS VARRAY(1000) OF varchar2(255);
  lista_nume varr := varr('Ababei','Acasandrei','Adascalitei','Afanasie','Agafitei','Agape','Aioanei','Alexandrescu','Alexandru','Alexe','Alexii','Amarghioalei','Ambroci','Andonesei','Andrei','Andrian','Andrici','Andronic','Andros','Anghelina','Anita','Antochi','Antonie','Apetrei','Apostol','Arhip','Arhire','Arteni','Arvinte','Asaftei','Asofiei','Aungurenci','Avadanei','Avram','Babei','Baciu','Baetu','Balan','Balica','Banu','Barbieru','Barzu','Bazgan','Bejan','Bejenaru','Belcescu','Belciuganu','Benchea','Bilan','Birsanu','Bivol','Bizu','Boca','Bodnar','Boistean','Borcan','Bordeianu','Botezatu','Bradea','Braescu','Budaca','Bulai','Bulbuc-aioanei','Burlacu','Burloiu','Bursuc','Butacu','Bute','Buza','Calancea','Calinescu','Capusneanu','Caraiman','Carbune','Carp','Catana','Catiru','Catonoiu','Cazacu','Cazamir','Cebere','Cehan','Cernescu','Chelaru','Chelmu','Chelmus','Chibici','Chicos','Chilaboc','Chile','Chiriac','Chirila','Chistol','Chitic','Chmilevski','Cimpoesu','Ciobanu','Ciobotaru','Ciocoiu','Ciofu','Ciornei','Citea','Ciucanu','Clatinici','Clim','Cobuz','Coca','Cojocariu','Cojocaru','Condurache','Corciu','Corduneanu','Corfu','Corneanu','Corodescu','Coseru','Cosnita','Costan','Covatariu','Cozma','Cozmiuc','Craciunas','Crainiceanu','Creanga','Cretu','Cristea','Crucerescu','Cumpata','Curca','Cusmuliuc','Damian','Damoc','Daneliuc','Daniel','Danila','Darie','Dascalescu','Dascalu','Diaconu','Dima','Dimache','Dinu','Dobos','Dochitei','Dochitoiu','Dodan','Dogaru','Domnaru','Dorneanu','Dragan','Dragoman','Dragomir','Dragomirescu','Duceac','Dudau','Durnea','Edu','Eduard','Eusebiu','Fedeles','Ferestraoaru','Filibiu','Filimon','Filip','Florescu','Folvaiter','Frumosu','Frunza','Galatanu','Gavrilita','Gavriliuc','Gavrilovici','Gherase','Gherca','Ghergu','Gherman','Ghibirdic','Giosanu','Gitlan','Giurgila','Glodeanu','Goldan','Gorgan','Grama','Grigore','Grigoriu','Grosu','Grozavu','Gurau','Haba','Harabula','Hardon','Harpa','Herdes','Herscovici','Hociung','Hodoreanu','Hostiuc','Huma','Hutanu','Huzum','Iacob','Iacobuta','Iancu','Ichim','Iftimesei','Ilie','Insuratelu','Ionesei','Ionesi','Ionita','Iordache','Iordache-tiroiu','Iordan','Iosub','Iovu','Irimia','Ivascu','Jecu','Jitariuc','Jitca','Joldescu','Juravle','Larion','Lates','Latu','Lazar','Leleu','Leon','Leonte','Leuciuc','Leustean','Luca','Lucaci','Lucasi','Luncasu','Lungeanu','Lungu','Lupascu','Lupu','Macariu','Macoveschi','Maftei','Maganu','Mangalagiu','Manolache','Manole','Marcu','Marinov','Martinas','Marton','Mataca','Matcovici','Matei','Maties','Matrana','Maxim','Mazareanu','Mazilu','Mazur','Melniciuc-puica','Micu','Mihaela','Mihai','Mihaila','Mihailescu','Mihalachi','Mihalcea','Mihociu','Milut','Minea','Minghel','Minuti','Miron','Mitan','Moisa','Moniry-abyaneh','Morarescu','Morosanu','Moscu','Motrescu','Motroi','Munteanu','Murarasu','Musca','Mutescu','Nastaca','Nechita','Neghina','Negrus','Negruser','Negrutu','Nemtoc','Netedu','Nica','Nicu','Oana','Olanuta','Olarasu','Olariu','Olaru','Onu','Opariuc','Oprea','Ostafe','Otrocol','Palihovici','Pantiru','Pantiruc','Paparuz','Pascaru','Patachi','Patras','Patriche','Perciun','Perju','Petcu','Pila','Pintilie','Piriu','Platon','Plugariu','Podaru','Poenariu','Pojar','Popa','Popescu','Popovici','Poputoaia','Postolache','Predoaia','Prisecaru','Procop','Prodan','Puiu','Purice','Rachieru','Razvan','Reut','Riscanu','Riza','Robu','Roman','Romanescu','Romaniuc','Rosca','Rusu','Samson','Sandu','Sandulache','Sava','Savescu','Schifirnet','Scortanu','Scurtu','Sfarghiu','Silitra','Simiganoschi','Simion','Simionescu','Simionesei','Simon','Sitaru','Sleghel','Sofian','Soficu','Sparhat','Spiridon','Stan','Stavarache','Stefan','Stefanita','Stingaciu','Stiufliuc','Stoian','Stoica','Stoleru','Stolniceanu','Stolnicu','Strainu','Strimtu','Suhani','Tabusca','Talif','Tanasa','Teclici','Teodorescu','Tesu','Tifrea','Timofte','Tincu','Tirpescu','Toader','Tofan','Toma','Toncu','Trifan','Tudosa','Tudose','Tuduri','Tuiu','Turcu','Ulinici','Unghianu','Ungureanu','Ursache','Ursachi','Urse','Ursu','Varlan','Varteniuc','Varvaroi','Vasilache','Vasiliu','Ventaniuc','Vicol','Vidru','Vinatoru','Vlad','Voaides','Vrabie','Vulpescu','Zamosteanu','Zazuleac');
  lista_prenume_fete varr := varr('Adina','Alexandra','Alina','Ana','Anca','Anda','Andra','Andreea','Andreia','Antonia','Bianca','Camelia','Claudia','Codrina','Cristina','Daniela','Daria','Delia','Denisa','Diana','Ecaterina','Elena','Eleonora','Elisa','Ema','Emanuela','Emma','Gabriela','Georgiana','Ileana','Ilona','Ioana','Iolanda','Irina','Iulia','Iuliana','Larisa','Laura','Loredana','Madalina','Malina','Manuela','Maria','Mihaela','Mirela','Monica','Oana','Paula','Petruta','Raluca','Sabina','Sanziana','Simina','Simona','Stefana','Stefania','Tamara','Teodora','Theodora','Vasilica','Xena');
  lista_prenume_baieti varr := varr('Adrian','Alex','Alexandru','Alin','Andreas','Andrei','Aurelian','Beniamin','Bogdan','Camil','Catalin','Cezar','Ciprian','Claudiu','Codrin','Constantin','Corneliu','Cosmin','Costel','Cristian','Damian','Dan','Daniel','Danut','Darius','Denise','Dimitrie','Dorian','Dorin','Dragos','Dumitru','Eduard','Elvis','Emil','Ervin','Eugen','Eusebiu','Fabian','Filip','Florian','Florin','Gabriel','George','Gheorghe','Giani','Giulio','Iaroslav','Ilie','Ioan','Ion','Ionel','Ionut','Iosif','Irinel','Iulian','Iustin','Laurentiu','Liviu','Lucian','Marian','Marius','Matei','Mihai','Mihail','Nicolae','Nicu','Nicusor','Octavian','Ovidiu','Paul','Petru','Petrut','Radu','Rares','Razvan','Richard','Robert','Roland','Rolland','Romanescu','Sabin','Samuel','Sebastian','Sergiu','Silviu','Stefan','Teodor','Teofil','Theodor','Tudor','Vadim','Valentin','Valeriu','Vasile','Victor','Vlad','Vladimir','Vladut');
  lista_numescena varr := varr('Alliterative','Nicknames','Pointless','Peter','Peter','the','Particular','Peppery','Peter','Peter','the','Personal','Emmanuel','the','Eager','Emmanuel','the','Exclusive','Pathetic','Peter','Peter','the','Pressing','Peter','the','Poor','Fish','Preposterous','Peter','Emmanuel','the','Even','Peter','the','Popular','Pungent','Peter','Descriptive','Nicknames','Blockheaded','Peter','Peter','the','Dazed','Confused','Peter','Asinine','Peter','Damned','Peter','Cloddish','Peter','Stupid','Peter','Clumsy','Peter','Brainless','Peter','Bad','Peter','Single','Peter','Peter','the','Consolidated','Consistent','Peter','Flat','Peter','Peter','the','Ace','Confederal','Peter','Centralized','Peter','All','Peter','Different','Peter','Peter','the','1','Hot','Peter','Calorifacient','Peter','Calorific','Peter','Blistering','Peter','Peter','the','Calefacient','Cute','Peter','Peter','the','Baking','Baking','Hot','Peter','Charged','Peter','Peter','the','Boil','Ironic','Nicknames','Cold','Peter','Cool','Peter','Double','Peter','Married','Peter','Intelligent','Peter','Smart','Peter','Rhyming','Nicknames','Meter','Peter','Sweeter','Peter','Store','Moore','Moore','the','Door','Emmanuel','the','Faneuil','Score','Moore','Ensure','Moore','Peter','the','Metre','Manual','Emmanuel','Obscure','Moore','Neater','Peter','Annual','Emmanuel','Skeeter','Peter','Emmanuel','the','Emanuel','More','Moore','Peter','the','Anteater','Teeter','Peter','Moore','the','War','Initial-Based','Nicknames','P.M','P.E','Pee','PeeEeEm','Computer','Generator','Slang','Petie','Peta','Petella','Moorie','Moorella','Moora','Known','to','Partner','As','Peter-nova','Stupid','Baby','Single','Chip','Hot','Muffin','Peter','Bear','Peterbug','Peterkitten','The','Bob','Suffix','Petbob','Moorbob','Peterbob');
  lista_comentariu varr := varr('Lorem','ipsum','dolor','sit','amet,','consectetur','adipiscing','elit.','Maecenas','tempor','arcu','eget','velit','condimentum,','quis','tristique','lectus','mollis.','Duis','gravida','suscipit','diam','at','feugiat.','Integer','accumsan','congue','ante,','porttitor','vestibulum','erat','aliquam','a.','Nulla','facilisi.','Quisque','ornare','erat','non','quam','molestie','accumsan.','Duis','malesuada','viverra','sapien,','pretium','euismod','risus','auctor','et.','Vestibulum','luctus','porttitor','lacus,','ac','hendrerit','massa','luctus','vel.','Aenean','congue','varius','velit,','quis','maximus','erat','congue','vel.','Aliquam','eget','rhoncus','ligula.','Nam','pretium','ex','ligula,','eget','tempor','enim','auctor','quis.','Maecenas','bibendum','iaculis','orci,','in','interdum','massa','tincidunt','iaculis.','Orci','varius','natoque','penatibus','et','magnis','dis','parturient','montes,','nascetur','ridiculus','mus.','Morbi','sed','semper','nisl.','Donec','vel','lacinia','tortor.','Suspendisse','sollicitudin','velit','et','neque','commodo,','eget','egestas','dui','egestas.','Donec','vitae','neque','est.','Aenean','mauris','turpis,','lobortis','in','egestas','sit','amet,','vehicula','sagittis','nunc.','Ut','nec','pellentesque','mauris,','quis','ultricies','massa.','Nullam','eget','imperdiet','purus,','ullamcorper','dictum','orci.','Donec','id','convallis','felis,','ac','feugiat','ligula.','Morbi','finibus','nec','nisi','id','rhoncus.','Donec','et','purus','tincidunt,','mattis','eros','at,','facilisis','augue.','Donec','ut','tristique','elit.','Donec','vitae','accumsan','augue.','Proin','ullamcorper','porttitor','enim,','id','laoreet','risus','malesuada','sed.','Sed','posuere','eleifend','elit','efficitur','pellentesque.','Suspendisse','vitae','justo','rutrum,','pharetra','felis','at,','feugiat','dui.','Proin','tincidunt','sodales','libero,','ultrices','consequat','dolor','vulputate','a.','Quisque','gravida','pharetra','aliquet.','Nam','commodo','vel','felis','sed','elementum.','Nulla','lorem','turpis,','tincidunt','ac','augue','vel,','placerat','sagittis','dolor.','Donec','faucibus','dapibus','leo,','et','fermentum','diam','condimentum','eget.','Morbi','rutrum','ipsum','id','metus','interdum,','nec','sagittis','arcu','egestas.','Mauris','tempor','odio','eget','velit','laoreet','tristique','nec','eget','tortor.','Nulla','fermentum','ac','dolor','a','elementum.','Suspendisse','a','volutpat','est,','eu','viverra','ipsum.','Phasellus','et','nisi','aliquet,','porta','felis','ut,','malesuada','erat.','Nulla','rutrum','mattis','vehicula.','Vestibulum','eu','semper','ex.','Quisque','convallis','felis','non','arcu','molestie','placerat.','Fusce','placerat','tempor','imperdiet.','Integer','dictum','feugiat','lectus','id','rhoncus.','Sed','luctus','neque','in','velit','tempor','imperdiet.','Nam','blandit','arcu','eu','mauris','tempus','pulvinar','fringilla','quis','nisi.','Vestibulum','malesuada','orci','in','sagittis','porttitor.','Nunc','vel','faucibus','eros.','Cras','feugiat','tincidunt','urna.','In','hac','habitasse','platea','dictumst.','Praesent','a','ultricies','elit.','Mauris','euismod','vestibulum','est','nec','molestie.','Cras','eros','quam,','tristique','eu','ante','sed,','interdum','tempor','ex.','Vestibulum','eget','tincidunt','odio.','Maecenas','varius','egestas','accumsan.','Cras','sodales','quam','elit,','eget','ultricies','leo','porta','sed.','Pellentesque','tristique','blandit','auctor.','Maecenas','at','elementum','nibh.','Mauris','facilisis','lectus','lacus,','at','vehicula','urna','vehicula','non.','Vivamus','sed','odio','felis.','Integer','tempus','lectus','vitae','urna','luctus','suscipit.');
  v_nume VARCHAR2(255);
  v_prenume VARCHAR2(255);
  v_prenume1 VARCHAR2(255);
  v_prenume2 VARCHAR2(255);
  v_username VARCHAR2(255);
  v_password varchar2(255);
  v_encrypt raw(100);
  v_admin INT;
  v_ban INT;
  v_length INT;
  lista_piese varr := varr('Truly','Madly','Pointy','A','Song','for','Jack','Behind','Pointy','Thoughts','The','Head','Where','Your','Heart','Should','Be','You','Dont','Send','Me','Pointy','Thoughts','Anymore','You','Cant','Chuckle','Through','A','Buffalo','Herd','Youve','Lost','That','Pointy','Head','Here','Without','Jack','Dont','Eat','Thoughts','Off','The','Sidewalk','My','Head','Sounds','Better','With','You','Pointy','Blues','Somewhere','Over','the','Head','Like','a','Head','Jacks','Pointy','Thoughts','Club','Band','Just','Another','a','Pointy','Head','Pointy','Head','O','Mine','You','Think','I','Aint','Worth','A','Head','But','I','Feel','Like','A','Million','Thoughts','My','Head','Wants','To','Kill','Your','Mama','Look','Jack,','are','you','going','to','Chuckle','With','Me','or','Not?','The','Girl','From','My','Office','Lets','Run','Away','to','My','Office','and','Swim','With','Thoughts','Cant','Take','My','Thoughts','Off','You','Chuckle?','I','Jolly','Well','Wont','Chuckle','Head','Boogie','It','Hurts','To','Shoot','Thoughts','From','Your','Head,','But','Its','Necessary','Many','Pieces','Of','Large','Fuzzy','Thoughts','Gathered','Together','At','My','Office','And','Grooving','On','A','Head','We','Shall','Chuckle','Stairway','to','Thoughts','In','Head','We','Trust','Every','Head','You','Take','Chuckle','-','It','is','the','Most','Fun','a','Girl','Can','Have','Smack','My','Head','Up','Nice','Weather','For','Thoughts','Stand','by','Your','Head','Hey','Jack','Whole','Lotta','Pointy','Thoughts','Your','Cheatin','Head','I','Chuckle','Pointy','Rhapsody','Look','Jack,','this','is','my','Head','Like','Pointy','Thoughts','(I','Cant','Get','No)','Pointy','Thoughts','One','Angry','Head','And','200','Pointy','Thoughts','Great','Balls','of','Thoughts','I','Chuckle','in','Your','Arms','When','Pointy','Thoughts','Chuckle','Youve','Lost','That','Pointy','Feeling','Baby,','I','Need','Your','Thoughts','Sweet','Head','O','Mine','Thoughts','in','My','Head','Head','Deep,','Thoughts','High','A','Lot','Of','People','Tell','Me','I','Have','A','Fake','Head','Theres','A','Good','Reason','Thoughts','Are','Numbered,','Jack','They','Are','Night','Thoughts!','They','Have','Come','Back','From','My','Office!!','Ahhhh!','Smells','Like','Pointy','Thoughts','Whole','Lotta','Thoughts','Jack','Eat','My','Pointy','Thoughts','in','My','Office','Total','Eclipse','of','the','Head','Chuckle,','Chuckle,','Chuckle!','This','Is','A','Sight','We','Had','One','Day','From','Pointy','My','Office','Jacks','Waiting','My','Office','is','Your','Land','Head','I','Have','Become','Amazing','Jack','She','Thinks','Heads','Sexy','Late','Night','Head','Jack','Broke','My','Heart','At','My','Office','Head','Autopsy','Enter','Jack','Hotel','My','Office','Your','Pointy','Heart','Goody','Two','Thoughts','My','Name','is','Jack','Yearning','for','Pointy','Thoughts','The','Homecoming','Queens','Got','A','Head','Bridge','Over','Pointy','Thoughts','Born','Pointy','Ring','of','Head','Have','You','Met','Jack?','Stand','by','Your','Thoughts','Careful','With','That','Head','Pointy','Thoughts','Forever','Welcome','to','Pointy','My','Office','Independent','Head','Mammas','Dont','Let','Your','Babies','Grow','Up','to','Be','Thoughts','Bed','of','Thoughts','Chuckle','This','Way','House','of','the','Pointy','Head','Chuckle','Forever','My','Office','on','My','Mind','Thoughts','Sound','Better','With','You','Like','a','Pointy','Head','Straight','Outta','My','Office','Rhythm','of','the','Head','Another','Year','of','Thoughts','Early','Morning','Head','Its','the','End','Of','My','Office','As','We','Know','It','And','I','Feel','FinE','Stairway','to','Head','Four','Pointy','Thoughts','Head','Fields','Forever');
  lista_piese2 varr := varr('Great','Thoughts','of','Head','Straight','Outta','My','Office','Head','Fields','Forever','Whole','Lotta','Thoughts','Many','Pieces','Of','Large','Fuzzy','Thoughts','Gathered','Together','At','My','Office','And','Grooving','On','A','Head','Livin','on','a','Head','Head','Deep,','Thoughts','High','Thoughts','Sound','Better','With','You','Ring','of','Head','Baby,','I','Need','Your','Thoughts','Pointy','Thoughts','Forever','Rhythm','of','the','Head','Dont','Chuckle','The','Homecoming','Queens','Got','A','Head','Chuckle','Forever','Jack','Eat','My','Pointy','Thoughts','in','My','Office','I','Chuckle','in','Your','Arms','Cant','Take','My','Thoughts','Off','You','Youve','Lost','That','Pointy','Feeling','Just','Another','a','Pointy','Head','I','Cant','Get','No','Pointy','Thoughts','Independent','Head','House','of','the','Pointy','Head','Stand','by','Your','Thoughts','Youve','Lost','That','Pointy','Head','Stairway','to','My','Office','The','Girl','From','My','Office','Total','Eclipse','of','the','Head','Theres','A','Good','Reason','Thoughts','Are','Numbered,','Jack','Stairway','to','Head','Goody','Two','Thoughts','Careful','With','That','Head','Smack','My','Head','Up','At','Least','Give','Me','My','Thoughts','Back,','You','Negligent','Head!','Chuckle,','Chuckle,','Chuckle!','Pointy','Head','O','Mine','Early','Morning','Head','My','Name','is','Jack','My','Head','Sounds','Better','With','You','Early','Morning','Chuckle','Smells','Like','a','Pointy','Head','You','Dont','Send','Me','Pointy','Thoughts','Anymore','A','Song','for','Jack','The','Number','of','your','Head','Smells','Like','Pointy','Thoughts','Like','a','Pointy','Head','Mammas','Dont','Let','Your','Babies','Grow','Up','to','Be','Thoughts','Jacks','Waiting','In','Head','We','Trust','This','Is','A','Sight','We','Had','One','Day','From','Pointy','My','Office','Where','Have','All','the','Thoughts','Gone?','Hey','Jack','Takin','the','Head','Train','Look','Jack,','this','is','my','Head','Free','Head','Jacks','Pointy','Thoughts','Club','Band','I','plead','Head','Chuckle','-','It','is','the','Most','Fun','a','Girl','Can','Have','Enter','Jack','Behind','Pointy','Thoughts','Pointy','Blues','Every','Head','You','Take','It','Hurts','To','Shoot','Thoughts','From','Your','Head,','But','Its','Necessary','Yearning','for','Pointy','Thoughts','Chuckle','This','Way','Late','Night','Head','You','Cant','Chuckle','Through','A','Buffalo','Herd','Bridge','Over','Pointy','Thoughts','Its','the','End','Of','My','Office','As','We','Know','It','(And','I','Feel','Fine)','Somewhere','Over','the','Head','Another','Head','in','the','Wall','One','Angry','Head','And','200','Pointy','Thoughts','Stand','By','Jack','My','Office','on','My','Mind','My','Office','is','Your','Land','A','Lot','Of','People','Tell','Me','I','Have','A','Fake','Head','Head','Boogie','She','Thinks','Heads','Sexy','Head','Autopsy','Your','Pointy','Heart','Good','Head','Truly','Madly','Pointy','They','Are','Night','Thoughts!','They','Have','Come','Back','From','My','Office!!','Ahhhh!','Head','I','Have','Become','Mad','to','Chuckle','Welcome','to','Pointy','My','Office','Your','Cheatin','Head','Chuckle?','I','Jolly','Well','Wont','Chuckle','Gonna','Make','You','Chuckle','Ghost','in','My','Head','Have','You','Met','Jack?','My','Head','Wants','To','Kill','Your','Mama','You','Think','I','Aint','Worth','A','Head','But','I','Feel','Like','A','Million','Thoughts','The','Head','Where','Your','Heart','Should','Be','Four','Pointy','Thoughts','Jack','Broke','My','Heart','At','My','Office','Stand','by','Your','Head','Born','Pointy','Amazing','Jack','Give','Me','Your','Thoughts');
  lista_genuri varr := varr('Art Punk','Alternative Rock','Britpunk','College Rock','Crossover Thrash (thx Kevin G)','Crust Punk (thx Haug)','Emotional Hardcore (emo / emocore) – (Thanks Timothy)','Experimental Rock','Folk Punk','Goth / Gothic Rock','Grunge','Hardcore Punk','Hard Rock','Indie Rock','Lo-fi (hat tip to Ben Vee Bedlamite)','Musique Concrète','New Wave','Progressive Rock','Acoustic Blues','African Blues','Blues Rock','Blues Shouter','British Blues','Canadian Blues','Chicago Blues','Classic Blues','Classic Female Blues','Contemporary Blues','Contemporary R&B','Country Blues','Delta Blues','Detroit Blues','Electric Blues','Folk Blues','Gospel Blues','Harmonica Blues','Hill Country Blues','Hokum Blues','Jazz Blues','Jump Blues','Kansas City Blues','Louisiana Blues','Memphis Blues','Modern Blues','New Orlean Blues','NY Blues','Piano Blues','Piedmont Blues','Punk Blues','Ragtime Blues (cheers GFS)','Rhythm Blues','Soul Blues','St. Louis Blues','Soul Blues','Swamp Blues','Texas Blues','Urban Blues','Vandeville','West Coast Blues','Club / Club Dance (thx Luke Allfree)','Breakcore','Breakbeat / Breakstep','4-Beat','Acid Breaks','Baltimore Club','Big Beat','Breakbeat Hardcore','Broken Beat','Florida Breaks','Nu Skool Breaks','Brostep (cheers Tom Berckley)','Chillstep (thx Matt)','Deep House (cheers Venus Pang)','Dubstep','Electro House (thx Luke Allfree)','Electroswing','Exercise','Future Garage (thx Ran’dom Haug)','Garage','Glitch Hop (cheers Tom Berckley)','Glitch Pop (thx Ran’dom Haug)','Grime (thx Ran’dom Haug / Matthew H)','Hardcore','Bouncy House','Bouncy Techno','Breakcore','Digital Hardcore','Doomcore','Dubstyle','Gabber','Happy Hardcore','Hardstyle','Jumpstyle','Makina','Speedcore','Terrorcore','Uk Hardcore','Hard Dance','Hi-NRG / Eurodance','Horrorcore (thx Matt)','House','Acid House','Chicago House','Deep House','Diva House','Dutch House','Electro House','Freestyle House','French House','Funky House','Ghetto House','Hardbag','Hip House','Italo House','Latin House','Minimal House','Progressive House','Rave Music','Swing House','Tech HouseTribal House','UK Hard House','US Garage','Vocal House','Jackin House (with thx to Jermaine Benjamin Dale Bruce)','Jungle / Drum’n’bass','Liquid Dub(thx Ran’dom Haug)','Regstep (thanks to ‘Melia G)','Speedcore (cheers Matt)','Techno','Acid Techno','Detroit Techno','Free Tekno','Ghettotech','Minimal','Nortec','Schranz','Techno-Dnb','Technopop','Tecno Brega','Toytown Techno','Acid Rock (with thanks to Alex Antonio)','Adult-Oriented Rock (thanks to John Maher)','Afro Punk','Adult Alternative','Alternative Rock (thx Caleb Browning)','American Traditional Rock','Anatolian Rock','Arena Rock','Art Rock','Blues-Rock','British Invasion','Cock Rock','Death Metal / Black Metal','Doom Metal (thx Kevin G)','Glam Rock','Gothic Metal (fits here Sam DeRenzis – thx)','Grind Core','Hair Metal','Hard Rock','Math Metal (cheers Kevin)','Math Rock (thx Ran’dom Haug)','Metal','Metal Core (thx Ran’dom Haug)','Noise Rock (genre – Japanoise – thx Dominik Landahl)','Jam Bands','Post Punk (thx Ben Vee Bedlamite)','Prog-Rock/Art Rock','Progressive Metal (thx Ran’dom Haug)','Psychedelic','Rock & Roll','Rockabilly (it’s here Mark Murdock!)','Roots Rock','Singer/Songwriter','Southern Rock','Spazzcore (thx Haug)','Stoner Metal (duuuude)','Surf','Technical Death Metal (cheers Pierre)','Tex-Mex','Thrash Metal (thanks to Pierre A)','Time Lord Rock (Trock) ~ (thanks to ‘Melia G)');
  my_str varchar2(4000);
  v_nume1 varchar2(255);
  v_descriere varchar2(512);
  v_link varchar2(512):='https://';
  v_com varchar2(10) :='.com';
  v_voturi INT;
  v_userfk INT;
  v_tmp INT;
  v_id INT;
  v_tmp2 INT;
  v_tmp3 INT;
  v_tmp4 INT;
  v_tmp5 INT;
  v_tmp6 INT;
  --INSERAM 1.000.000 USERI IN TABELA
  BEGIN
  
DBMS_OUTPUT.PUT_LINE('am terminat de construit tabelele');

DBMS_OUTPUT.PUT_LINE('populam tabela useri cu 1.000.000 entitati ...');
   FOR v_i IN 1..100 LOOP
      v_nume := lista_nume(TRUNC(DBMS_RANDOM.VALUE(0,lista_nume.count))+1);
      IF (DBMS_RANDOM.VALUE(0,100)<50) THEN      
         v_prenume1 := lista_prenume_fete(TRUNC(DBMS_RANDOM.VALUE(0,lista_prenume_fete.count))+1);
         LOOP
            v_prenume2 := lista_prenume_fete(TRUNC(DBMS_RANDOM.VALUE(0,lista_prenume_fete.count))+1);
            exit when v_prenume1<>v_prenume2;
         END LOOP;
       ELSE
         v_prenume1 := lista_prenume_baieti(TRUNC(DBMS_RANDOM.VALUE(0,lista_prenume_baieti.count))+1);
         LOOP
            v_prenume2 := lista_prenume_baieti(TRUNC(DBMS_RANDOM.VALUE(0,lista_prenume_baieti.count))+1);
            exit when v_prenume1<>v_prenume2;
         END LOOP;       
       END IF;
     
     IF (DBMS_RANDOM.VALUE(0,100)<15) THEN  
        IF LENGTH(v_prenume1 || ' ' || v_prenume2) <= 20 THEN
          v_prenume := v_prenume1 || ' ' || v_prenume2;
        END IF;
        else 
           v_prenume:=v_prenume1;
      END IF;
      if(DBMS_RANDOM.VALUE(0,100)<50) THEN
       v_username:=v_nume||'_'||v_prenume;
       ELSE
       v_username:=v_nume||''||v_prenume;
       END IF;
       v_length:=floor(DBMS_RANDOM.VALUE(5,15));
       v_password:=null;
       for i in 1..v_length loop
        v_password := v_password || dbms_random.string(
            case when dbms_random.value(0, 1) < 0.5 then 'l' else 'x' end, 1);
        end loop;
        select crypto.CRYPTING_PASS(v_password) into v_encrypt from dual;
       
      if(DBMS_RANDOM.VALUE(0,100)<0.1) THEN
       v_admin:= 1;
       else
       v_admin:=0;
       end if;
       if(DBMS_RANDOM.VALUE(0,100)<3) THEN
       v_ban:= 1;
       else
       v_ban:=0;
       
       end if;
       v_username:=substr(v_username,1,29);
       
      insert into useri values(usr_seq.nextval, v_username, v_encrypt, v_admin, v_ban, sysdate, sysdate);
   END LOOP;
   
   
DBMS_OUTPUT.PUT_LINE('am terminat de populat useri!');

--inseram artistii

DBMS_OUTPUT.PUT_LINE('populam tabela artists cu 10.000 entitati...');
   
   --inseram 1000 de artisti 
   FOR v_i IN 1..20 LOOP
      v_nume := lista_nume(TRUNC(DBMS_RANDOM.VALUE(0,lista_nume.count))+1);
      IF (DBMS_RANDOM.VALUE(0,100)<50) THEN      
         v_prenume1 := lista_prenume_fete(TRUNC(DBMS_RANDOM.VALUE(0,lista_prenume_fete.count))+1);
         LOOP
            v_prenume2 := lista_prenume_fete(TRUNC(DBMS_RANDOM.VALUE(0,lista_prenume_fete.count))+1);
            exit when v_prenume1<>v_prenume2;
         END LOOP;
       ELSE
         v_prenume1 := lista_prenume_baieti(TRUNC(DBMS_RANDOM.VALUE(0,lista_prenume_baieti.count))+1);
         LOOP
            v_prenume2 := lista_prenume_baieti(TRUNC(DBMS_RANDOM.VALUE(0,lista_prenume_baieti.count))+1);
            exit when v_prenume1<>v_prenume2;
         END LOOP;       
       END IF;
     
     IF (DBMS_RANDOM.VALUE(0,100)<55) THEN  
        IF LENGTH(v_prenume1 || ' ' || v_prenume2) <= 20 THEN
          v_prenume := v_prenume1 || ' ' || v_prenume2;
        END IF;
        else 
           v_prenume:=v_prenume1;
      END IF;
     v_length := FLOOR(DBMS_RANDOM.VALUE(1,3));
      my_str :=null;
      FOR v_ii IN 1..v_length LOOP
      
      my_str := my_str||' '||lista_numescena(TRUNC(DBMS_RANDOM.VALUE(0,lista_numescena.count))+1);
      END LOOP;
       
      insert into artists values(art_seq.nextval, v_nume, v_prenume, my_str, sysdate, sysdate);
   END LOOP;
   
DBMS_OUTPUT.PUT_LINE('am terminat de populat artists!');

DBMS_OUTPUT.PUT_LINE('populam tabela genuri...');
   
    --inseram genurile
    FOR v_i IN 1..lista_genuri.count LOOP
       v_nume:=lista_genuri(v_i);
      insert into genres values(gen_seq.nextval, v_nume, sysdate, sysdate);
      
  -- inseram comentariile
      
   END LOOP;
   DBMS_OUTPUT.PUT_LINE('am terminat de populat genuri!');
   
   DBMS_OUTPUT.PUT_LINE('populam songs cu 2.500.000 milioane de entitati...');
   
   select count(*) into v_tmp6 from useri;
   select count(*) into v_tmp2 from artists;
   select count(*) into v_tmp5 from genres;
   
    FOR v_i IN 1..2000 LOOP
      v_length := FLOOR(DBMS_RANDOM.VALUE(1,3));
      my_str :=null;
      FOR v_ii IN 1..v_length LOOP
      IF (DBMS_RANDOM.VALUE(0,100)<50) THEN
      my_str := my_str||' '||lista_piese(TRUNC(DBMS_RANDOM.VALUE(0,lista_piese.count))+1);
      else
      my_str := my_str||' '||lista_piese2(TRUNC(DBMS_RANDOM.VALUE(0,lista_piese2.count))+1);
      end if;
      end loop;
      v_nume1:=my_str;
      
      v_length := FLOOR(DBMS_RANDOM.VALUE(1,2));
      my_str :=null;
      FOR v_ii IN 1..v_length LOOP
      
      my_str := my_str||' '||lista_piese(TRUNC(DBMS_RANDOM.VALUE(0,lista_piese.count))+1);
     
      end loop;
      v_descriere:=my_str;
      my_str:=null;
      v_length := FLOOR(DBMS_RANDOM.VALUE(1,2));
      
      FOR v_ii IN 1..v_length LOOP
      
      my_str := my_str||''||lista_piese2(TRUNC(DBMS_RANDOM.VALUE(0,lista_piese2.count))+1);
     
      end loop;
      
      v_link:='www.'||my_str||v_com;
      v_voturi:=FLOOR(DBMS_RANDOM.VALUE(1,10000));
      
      v_userfk:=FLOOR(DBMS_RANDOM.VALUE(1,v_tmp6));
      v_id:=songs_seq.nextval; 
      insert into songs values(v_id, v_nume1, v_descriere, v_link, v_voturi,v_userfk, sysdate, sysdate);
      v_tmp4 := FLOOR(DBMS_RANDOM.VALUE(1,3));
      
      FOR v_j in 1..v_tmp4 LOOP
        
        v_tmp3:=FLOOR(DBMS_RANDOM.VALUE(1,v_tmp2+1));
        select count(*) into v_tmp from proxysongartist where artists_fk=v_tmp3 and songs_fk=v_id;
        if (v_tmp!=0) then
        v_tmp4:=v_tmp4+1;
        else
        insert into proxysongartist values(v_tmp3,v_id,sysdate,sysdate);
        end if;
        
      end LOOP;
      v_tmp4 := FLOOR(DBMS_RANDOM.VALUE(1,3));
     
      FOR v_j in 1..v_tmp4 LOOP
        
        v_tmp3:=FLOOR(DBMS_RANDOM.VALUE(1,v_tmp5+1));
        select count(*) into v_tmp from proxysonggenre where genres_fk=v_tmp3 and songs_fk=v_id;
        if (v_tmp!=0) then
        v_tmp4:=v_tmp4+1;
        else
        insert into proxysonggenre values(v_id,v_tmp3,sysdate,sysdate);
        -- DBMS_OUTPUT.PUT_LINE('am terminat de populat songs!');
        end if;
       
      end LOOP;
   END LOOP;
   
DBMS_OUTPUT.PUT_LINE('am terminat de populat songs!');
select count(*) into v_tmp from songs;
FOR v_i in 1..4000 loop
      v_length := FLOOR(DBMS_RANDOM.VALUE(10,20));
            my_str :=null;
            FOR v_ii IN 1..v_length LOOP
            
            my_str := my_str||' '||lista_comentariu(TRUNC(DBMS_RANDOM.VALUE(0,lista_comentariu.count))+1);
           
            end loop;
            v_descriere:=my_str;
            v_userfk:=FLOOR(DBMS_RANDOM.VALUE(1,v_tmp6+1));
            v_id:=comm_seq.nextval;
            insert into comments values (v_id, v_descriere,v_userfk, sysdate,sysdate);
            v_userfk:= FLOOR(DBMS_RANDOM.VALUE(1,v_tmp+1));
            insert into proxysongcomment values(v_userfk,v_id,sysdate,sysdate);

end loop;
end;

SELECT * FROM useri;
commit;