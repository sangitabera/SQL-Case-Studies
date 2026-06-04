USE spotify;

-- top 10 songs by spotify streams
SELECT Track,
Artist,
Spotify_Streams
FROM spotify
ORDER BY Spotify_Streams DESC
LIMIT 10 ;


-- top 10 artists by total streams
SELECT Artist,
SUM(Spotify_Streams) AS total_streams
FROM spotify
GROUP BY Artist
ORDER BY total_streams DESC
LIMIT 5;


-- artist ranking based on streams
WITH artist_streams AS
(
	SELECT Artist,
	SUM(Spotify_Streams) AS total_streams
	FROM spotify
	GROUP BY Artist
)
SELECT *, 
RANK() OVER(ORDER BY total_streams DESC) artist_rank
FROM artist_streams ;

-- most popular tracks
SELECT Artist,
Track,
Spotify_Popularity
FROM spotify
ORDER BY Spotify_Popularity DESC
LIMIT 10 ;


-- avg population by artist
SELECT Artist,
ROUND(AVG(Spotify_Popularity),2) AS avg_popularity
FROM spotify
GROUP BY Artist
ORDER BY avg_popularity DESC
LIMIT 5;



-- songs appearing in maximum spotify playlists
SELECT Artist,
Track,
Spotify_Playlist_Count
FROM spotify
ORDER BY Spotify_Playlist_Count DESC
LIMIT 5;



-- playlist reach leaders
SELECT Artist,
Track,
Spotify_Playlist_Reach
FROM spotify
ORDER BY Spotify_Playlist_Reach DESC
LIMIT 10;


-- top songs on youtube
SELECT Artist,
Track,
YouTube_Views
FROM spotify
ORDER BY YouTube_Views DESC
LIMIT 10;


-- youtube engagement rate
SELECT Artist,
Track,
ROUND(
		(YouTube_Likes * 100)/
        NULLIF(YouTube_Views,0),2) 
        AS engagement_rate
FROM spotify
ORDER BY engagement_rate DESC ;



-- most viral tiktok songs
SELECT Artist,
Track,
TikTok_Views
FROM spotify
ORDER BY TikTok_Views DESC
LIMIT 10  ;



-- tiktok engagement 
SELECT Artist,
Track,
ROUND(
		(TikTok_Likes * 100)/
        NULLIF(TikTok_Views,0),2) 
        AS engagement_rate
FROM spotify
ORDER BY engagement_rate DESC ;



-- explicit vs non-explicit songs
SELECT Explicit_Track,
COUNT(*) AS total_songs,
ROUND(
	AVG(Spotify_Popularity),2) AS avg_popularity
FROM spotify
GROUP BY Explicit_Track;



-- release year wise song count
SELECT YEAR(Release_Date) AS release_year,
COUNT(*) AS songs
FROM spotify
GROUP BY release_year
ORDER BY release_year;


-- top artist on multiple platforms
SELECT Artist,
SUM(Spotify_Streams) AS spotify_streams,
SUM(YouTube_Views) as youtube,
SUM(TikTok_Views) AS tiktok
FROM spotify
GROUP BY Artist;


-- top songs per artist
WITH ranked_songs AS 
(
SELECT Artist, 
		Track,
        Spotify_Streams,
        ROW_NUMBER() OVER(
			PARTITION BY Artist
            ORDER BY Spotify_Streams DESC
		) AS rn
FROM spotify
)
SELECT *
FROM ranked_songs
WHERE rn=1;