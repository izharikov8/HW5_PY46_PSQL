--1. 
select genre_name, count(singer_id) from genresinger g
join genre g2 on g.genre_id = g2.genre_id 
group by genre_name
order by count(singer_id) desc;

--2. 
select count(song_id), album_year from songs s 
join albums a on s.album_id = a.album_id
where album_year between 2010 and 2018
group by album_year;

--3. 
select album_name, AVG(duration) from albums a 
join songs s on a.album_id = s.album_id 
group by album_name;

--4. 
select singer_name from singer s 
where s.singer_name not in (
select distinct singer_name from singer s2
left join singeralbums s3 on s2.singer_id = s3.singer_id
left join albums a on a.album_id = s3.album_id
where album_year = 2018)
order by singer_name;

--5. 
select distinct(collection_name) from collection c 
join collectionsongs c2 on c.collection_id = c2.collection_id 
join songs s on c2.song_id = s.song_id 
join albums a on s.album_id = a.album_id 
join singeralbums s2 on a.album_id = s2.album_id 
join singer s3 on s2.singer_id = s3.singer_id 
where singer_name like 'ACDC';

--6. 
select album_name from albums a 
join singeralbums s on a.album_id = s.album_id 
join singer s2 on s.singer_id = s2.singer_id 
join genresinger g on s2.singer_id = g.singer_id 
join genre g2 on g.genre_id = g2.genre_id
group by album_name
having count(distinct genre_name) > 1;

--7. 
select song_name from songs s 
left join collectionsongs c on s.song_id = c.song_id 
where c.song_id is null;

--8. 
select singer_name, duration from songs s 
join albums a on s.album_id = a.album_id
join singeralbums s2 on a.album_id = s2.album_id 
join singer s3 on s3.singer_id = s2.singer_id
group by singer_name, duration
having duration = (select min(duration) from songs);

--9. 
select distinct album_name from albums a 
where a.album_id in (
select album_id from songs
group by album_id
having count(album_id) = (select count(song_id) from songs
group by album_id
order by count
limit 1));
