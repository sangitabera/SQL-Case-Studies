USE ipl;

-- Total IPL matches played
SELECT COUNT(*) AS total_matches
FROM matches;


-- number of seasons in ipl
SELECT COUNT(DISTINCT season) AS total_seasons
FROM matches;


-- teams with most wins
SELECT winner, COUNT(*) AS wins
FROM matches
WHERE winner IS NOT NULL
GROUP BY winner
ORDER BY wins DESC LIMIT 5;


-- top 10 run scorers in IPL
SELECT batter, SUM(batsman_runs) AS total_runs
FROM deliveries
GROUP BY batter
ORDER BY total_runs DESC 
LIMIT 10 ;


-- top 10 wicket takers
SELECT bowler, COUNT(*) AS wickets
FROM deliveries
WHERE is_wicket = 1
GROUP BY bowler
ORDER BY wickets DESC
LIMIT 10 ;


-- most player of the match
SELECT player_of_match,
COUNT(*) AS awards
FROM matches
GROUP BY player_of_match
ORDER BY awards DESC
LIMIT 10 ;


-- number of matches won by each team
SELECT winner ,COUNT(*) AS wins
FROM matches
GROUP BY winner
ORDER BY wins DESC ;


-- teams winning toss most frequently
SELECT toss_winner, COUNT(*) AS toss_wins
FROM matches
GROUP BY toss_winner
ORDER BY toss_wins DESC ;


-- toss winner vs match winner
SELECT COUNT(*) AS matches, 
SUM(CASE
		WHEN toss_winner = winner
        THEN 1
        ELSE 0
	END) AS toss_and_match_win
FROM matches ; 


-- teams preferring batting first
SELECT toss_winner, COUNT(*) AS batting_first
FROM matches
WHERE toss_decision = 'bat'
GROUP BY toss_winner
ORDER BY batting_first DESC ;


-- teams preferring bowling first
SELECT toss_winner, COUNT(*) AS bowling_first
FROM matches
WHERE toss_decision = 'field'
GROUP BY toss_winner
ORDER BY bowling_first DESC ;


-- Highest team score
SELECT batting_team, SUM(total_runs) AS score
FROM deliveries
GROUP BY match_id, inning, batting_team
ORDER BY score DESC
LIMIT 10;


-- lowest team score
SELECT batting_team, SUM(total_runs) AS score
FROM deliveries
GROUP BY match_id, inning, batting_team
ORDER BY score ASC
LIMIT 10;


-- highest individual score
SELECT batter, match_id, SUM(batsman_runs) AS runs
FROM deliveries
GROUP BY batter, match_id
ORDER BY runs DESC
LIMIT 10 ;


-- most sixes in IPL
SELECT batter, COUNT(*) AS sixes
FROM deliveries
WHERE batsman_runs = 6
GROUP BY batter
ORDER BY sixes DESC
LIMIT 5;


-- most fours in IPL
SELECT batter, COUNT(*) AS fours
FROM deliveries
WHERE batsman_runs = 4
GROUP BY batter
ORDER BY fours DESC
LIMIT 5;


-- best economy bowlers
SELECT bowler,
ROUND(SUM(total_runs)/(COUNT(*)/6),2) AS economy
FROM deliveries
GROUP BY bowler
ORDER BY economy ASC
LIMIT 10;


-- most sucessfull venue
SELECT venue, COUNT(*) AS matches_played
FROM matches
GROUP BY venue
ORDER BY matches_played DESC
LIMIT 5;


-- team winning percentage
SELECT winner, COUNT(*)*100.0 / 
(SELECT COUNT(*) FROM matches) AS win_percentage
FROM matches
GROUP BY winner
ORDER BY win_percentage DESC ;


-- orange cap holders
SELECT m.season, d.batter, SUM(d.batsman_runs) AS runs
FROM deliveries d
JOIN matches m
ON d.match_id = m.id
GROUP BY m.season, d.batter
ORDER BY m.season, runs DESC;


-- season-wise winners
SELECT season,
winner,
COUNT(*) AS wins
FROM matches
GROUP BY season, winner
ORDER BY season ;


-- death over specialist
SELECT bowler, COUNT(*) AS wickets
FROM deliveries 
WHERE over = 16
AND is_wicket = 1
GROUP BY bowler
ORDER BY wickets DESC
LIMIT 10;


-- most runs against a particular team
SELECT batter, bowling_team, SUM(batsman_runs) AS runs
FROM deliveries
GROUP BY batter, bowling_team
ORDER BY runs DESC
LIMIT 5;