select index_name from user_indexes;

select * from songs where nume like '%You%';

select * from songs;

create index index_songs_nume on songs(nume);


select * from songs s inner join proxysongartist psa on s.songs_id=psa.songs_fk inner join artists a on a.artists_id=psa.artists_fk inner join proxysonggenre psg on psg.songs_fk=s.songs_id inner join genres g on g.genres_id=psg.genres_fk  inner join proxysongcomment psc on s.songs_id=psc.songs_fk inner join comments c on c.comments_id=psc.comments_fk ;