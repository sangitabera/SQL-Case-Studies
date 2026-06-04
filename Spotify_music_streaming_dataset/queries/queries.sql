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




-- stream quartile 
SELECT Track,
Artist,
Spotify_Streams,
NTILE(4)
OVER(
	ORDER BY Spotify_Streams
) AS stream_quartile
FROM spotify ;


-- songs above artist average
SELECT *
FROM spotify s
WHERE Spotify_Streams >
(
SELECT AVG(Spotify_Streams)
FROM spotify
WHERE Artist = S.Artist
) ;


-- top 3 songs by every artist
WITH ranked AS 
(
SELECT 
Artist,
Track,
Spotify_Streams,
DENSE_RANK() OVER(
				PARTITION BY Artist
				ORDER BY Spotify_Streams DESC) 
                AS rnk
FROM spotify
)
SELECT * 
FROM ranked
WHERE rnk <=3 ;


-- running total streams
SELECT
Track,
Spotify_Streams,
SUM(Spotify_Streams) 
OVER(
ORDER BY Spotify_Streams DESC) AS running_total
FROM spotify ;


-- spotify vs youtube performance comparison
SELECT
Track,
Spotify_Streams,
Artist,
YouTube_Views,
CASE 
	WHEN Spotify_Streams > YouTube_Views
    THEN "Spotify Dominat"
    ELSE "Youtube Dominat"
END platform_lead
FROM spotify ;


-- artists with songs across multiple albums
SELECT Artist,
COUNT(DISTINCT Album_Name) AS albums
FROM spotify
GROUP BY Artist
ORDER BY albums DESC;


-- percentile ranking of songs
SELECT Artist,
Track,
PERCENT_RANK() OVER(
					ORDER BY Spotify_Streams) 
                    AS percentile_rank
FROM spotify
ORDER BY  percentile_rank DESC;


-- Cross platform reach
SELECT Artist,
Track,
(
Spotify_Streams +
YouTube_Views +
TikTok_Views +
Pandora_Streams) AS total_reach
FROM spotify
ORDER BY  total_reach DESC;


-- hidden artists 
SELECT Artist,
Track
FROM spotify
WHERE Spotify_Playlist_Count < 5000
AND Spotify_Popularity > 80 ;


-- total informations
SELECT Artist,
COUNT(*) AS total_tracks,
SUM(Spotify_Streams) AS total_streams,
AVG(Spotify_Popularity) AS avg_popularity,
SUM(YouTube_Views) AS youtube_views,
SUM(TikTok_Views) AS tiktok_views
FROM spotify
GROUP BY Artist
ORDER BY total_streams;