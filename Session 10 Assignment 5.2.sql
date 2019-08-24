drop schema if exists sounds_10_5_2_2; 
create schema sounds_10_5_2_2;
use sounds_10_5_2_2;

DROP TABLE IF EXISTS albums;
CREATE TABLE albums (
album_id int(11) NOT NULL AUTO_INCREMENT UNIQUE KEY,
album_artist_id int(11) NOT NULL,
album_title varchar(45) NOT NULL,
album_year year(4) NOT NULL,
album_type varchar(45) NOT NULL,
album_rating tinyint(4) NOT NULL,
PRIMARY KEY (album_id),
FOREIGN KEY fkey_album_artist_id(album_artist_id) REFERENCES artists (artist_id)
);
  
DROP TABLE IF EXISTS artists;
CREATE TABLE artists (
artist_id int(11) NOT NULL AUTO_INCREMENT UNIQUE KEY ,
artist_name varchar(45) NOT NULL,
nationality varchar(45) NOT NULL,
artist_type varchar(45) NOT NULL,
PRIMARY KEY (artist_id)
);
  
DROP TABLE IF EXISTS tracks;
CREATE TABLE tracks (
track_id int(11) NOT NULL AUTO_INCREMENT UNIQUE KEY,
track_album_id int(11) NOT NULL,
track_name varchar(45) NOT NULL,
track_length int(11) NOT NULL,
track_rating tinyint(4) NOT NULL,
track_number tinyint(4) NOT NULL,
PRIMARY KEY (track_id),
FOREIGN KEY fkey_track_album_id(track_album_id) REFERENCES albums (album_id)
);
