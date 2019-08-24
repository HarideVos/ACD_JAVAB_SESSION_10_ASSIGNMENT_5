-- 1
SELECT 
    *
FROM
    (SELECT 
        *
    FROM
        albums
    JOIN artists ON album_artist_id) b1,
    (SELECT 
        *
    FROM
        albums
    JOIN artists ON album_artist_id) b2
WHERE
    b2.album_year = b1.album_year
        AND b1.album_type = 'live'
        AND b2.album_type = 'compilation'
        AND b1.artist_id = b2.artist_id;
        
-- 2
SELECT 
    *
FROM
    artists,
    albums a1
WHERE
    album_artist_id IN (SELECT 
            album_artist_id
        FROM
            albums a2
        WHERE
            a2.album_type = 'live');
-- 3
SELECT * from
    albums ab1, artists as1
WHERE
    as1.artist_type = 'band'
        AND ab1.album_rating > (SELECT 
            MAX(album_rating)
        FROM
            albums
        WHERE
            as1.artist_id = albums.album_artist_id
                AND albums.album_year < ab1.album_year);
 
-- 4
SELECT 
    *
FROM
    albums ab1,
    artists as1
WHERE
    as1.nationality = 'English'
        AND ab1.album_rating > (SELECT 
            AVG(ab2.album_rating)
        FROM
            albums ab2
        WHERE
            ab1.album_year = ab2.album_year
                AND ab1.album_id != ab2.album_id);
 
 -- 5
SELECT 
    ab1.album_title, ar1.artist_name, t1.track_name
FROM
    albums ab1,
    artists ar1,
	tracks t1
WHERE
    album_year >= '1999'
        AND t1.track_album_id = ab1.album_id
        AND ab1.album_artist_id = ar1.artist_id
        AND t1.track_length < 154
        AND ab1.album_rating >= 4;
 
 -- 6
SELECT 
    SUM(tr.track_length), track_album_id
FROM
    albums al,
    tracks tr
WHERE
    al.album_year
        AND al.album_year BETWEEN 1990 AND 1999
        AND al.album_id = tr.track_album_id
GROUP BY tr.track_album_id;

-- 7
SELECT 
    *
FROM
    albums;

SELECT 
    *
FROM
    artists ar
WHERE
    ar.artist_id NOT IN (SELECT 
            ar.artist_id
        FROM
            artists ar,
            albums al,
            albums al2
        WHERE
            ar.artist_id = al.album_artist_id
                AND ar.artist_id = al2.album_artist_id
                AND al.album_id <> al2.album_id
                AND al.album_type = 'studio'
                AND DATEDIFF(al.album_year, al2.album_year) > 4
        ORDER BY al.album_year);
 
 -- 8
SELECT 
    artist_name
FROM
    artists ar
WHERE
    (SELECT 
            COUNT(album_type)
        FROM
            albums a1
        WHERE
            a1.album_type <> 'studio'
                AND a1.album_artist_id = ar.artist_id) > (SELECT 
            COUNT(album_type)
        FROM
            albums a2
        WHERE
            a2.album_type = 'studio'
                AND a2.album_artist_id = ar.artist_id);
 
 -- 9
SELECT 
    al.album_title, SUM(t.track_length)
FROM
    albums al,
    tracks t,
    artists ar
WHERE
    ar.artist_id = al.album_artist_id
        AND al.album_id = t.track_album_id
        AND al.album_id IN (SELECT 
            t2.track_album_id
        FROM
            tracks t2
        GROUP BY t2.track_album_id
        HAVING MAX(t2.track_number) = COUNT(t2.track_number))
GROUP BY al.album_title;
 
 -- 10
 
SELECT 
    ar.artist_name,
    al.album_title,
    al.album_rating,
    al.album_type
FROM
    artists ar,
    albums al
WHERE
    al.album_artist_id = ar.artist_id
HAVING COUNT(al.album_type = 'studio' >= 3)
    AND COUNT(al.album_type = 'live' >= 2)
    AND COUNT(al.album_type = 'compilation' >= 1)
    AND MIN(al.album_rating) >= 3;
 
 -- 11
SELECT 
    *
FROM
    artists ar,
    albums al
WHERE
    ar.artist_id = al.album_artist_id;
 
SELECT 
    COUNT(artist_name)
FROM
    artists ar,
    albums al
WHERE
    ar.artist_id = al.album_artist_id
        AND al.album_rating = '5'
        AND ar.nationality = 'American'
        AND artist_type = 'band'
        AND NOT EXISTS( SELECT 
            al2.album_year
        FROM
            albums al2
        WHERE
            al.album_artist_id = al2.album_artist_id
                AND al2.album_year < al.album_year);
 -- 12
 
 	
SELECT 
    *, TRUNCATE((lt3 / tot * 100), 2) AS P
FROM
    (SELECT 
        ar1.artist_name, ar1.artist_id, COUNT(*) AS lt3
    FROM
        albums al2, artists ar1
    WHERE
        al2.album_rating < 3
            AND ar1.artist_id = al2.album_artist_id
    GROUP BY ar1.artist_id) AS t1
        JOIN
    (SELECT 
        ar1.artist_name, ar1.artist_id, COUNT(*) AS tot
    FROM
        albums al2, artists ar1
    WHERE
        ar1.artist_id = al2.album_artist_id
    GROUP BY ar1.artist_id) AS t2 ON t1.artist_id = t2.artist_id
ORDER BY P;

-- 13
SELECT 
    f1.artist_id
FROM
    (SELECT DISTINCT
        artist_id, artist_name, nationality
    FROM
        albums al1, artists ar1
    WHERE
        ar1.artist_id = al1.album_artist_id
            AND al1.album_type = 'studio') AS f1
WHERE
    ((f1.artist_id <> ar2.album_artist_id
        AND f1.nationality = ar2.nationality)
        OR f1.nationality IN (SELECT 
            nationality
        FROM
            artists ar2
                JOIN
            albums al2 ON ar2.artist_id = al2.album_artist_id
        WHERE
            al2.album_type = 'studio'
        GROUP BY ar2.nationality
        HAVING COUNT(DISTINCT ar2.artist_id) = 1));

-- 13
SELECT 
    ar1.artist_name, COUNT(DISTINCT album_id)
FROM
    albums al1,
    artists ar1
WHERE
    al1.album_artist_id = ar1.artist_id
        AND al1.album_type = 'studio'
GROUP BY ar1.artist_id
HAVING COUNT(DISTINCT album_id) >= ALL (SELECT 
        COUNT(DISTINCT album_id)
    FROM
        albums al2,
        artists ar2
    WHERE
        ar1.nationality = ar2.nationality
            AND al2.album_type = 'studio'
    GROUP BY ar2.artist_id)
;


-- 14
SELECT 
    al1.album_title AS Higher,
    al1.album_rating,
    al2.album_title AS Lower,
    al2.album_rating
FROM
    albums al1
        JOIN
    artists ar1 ON ar1.artist_id = al1.album_artist_id,
    albums al2
        JOIN
    artists ar2 ON ar2.artist_id = al2.album_artist_id
WHERE
    ar2.artist_name != ar1.artist_name
        AND al1.album_year = al2.album_year
        AND al1.album_rating > al2.album_rating;


-- 15
SELECT 
    COUNT(al1.album_rating) / trc AS ratio, al1.album_title
FROM
    (albums al1
    JOIN (SELECT 
        t1.track_album_id, COUNT(t1.track_number) AS trc
    FROM
        tracks t1
    GROUP BY t1.track_album_id) AS tc ON tc.track_album_id = al1.album_id)
ORDER BY ratio DESC