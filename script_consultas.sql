--1) Média de eficiencia do jogador
SELECT g.club, g.player_name, g.goals
  FROM goals g
ORDER BY g.goals DESC
LIMIT 5;

WITH top_5 as (
SELECT g.player_name, g.goals
  FROM goals g
ORDER BY g.goals DESC
LIMIT 5)
SELECT att.club,
       att.player_name, 
       att.total_attempts, 
       tp.goals,
       (CAST(tp.goals AS FLOAT) / att.total_attempts) * 100 AS mean_goals
  FROM attempts att
  JOIN top_5 tp ON tp.player_name = att.player_name
ORDER BY mean_goals desc;

