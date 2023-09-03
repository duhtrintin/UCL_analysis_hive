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

--2) Top defensores
SELECT club, player_name, sum(pt_br) + sum(pt_tk) + sum(pt_tw) +  sum(pt_fo) + sum(pt_rd) + sum(pt_yw) AS resultado
  FROM (
        SELECT dc.club, dc.player_name, cast(0.5 * df.balls_recoverd AS FLOAT) AS pt_br, cast(0.5 * df.tackles AS FLOAT) AS pt_tk, df.t_won AS pt_tw, cast(-0.5 * dc.fouls_committed AS FLOAT) AS pt_fo, (-2 * dc.red) AS pt_rd, (-1 * dc.yellow) AS pt_yw
          FROM defending df 
          JOIN disciplinary dc ON dc.player_name = df.player_name
         WHERE df.position IN ('Midfielder', 'Defender')
           AND df.match_played > 5
  ) t
GROUP BY club, player_name
ORDER BY resultado DESC;

WITH dados_top_def AS (
SELECT club, player_name, sum(pt_br) + sum(pt_tk) + sum(pt_tw) +  sum(pt_fo) + sum(pt_rd) + sum(pt_yw) AS resultado
  FROM (
        SELECT dc.club, dc.player_name, cast(0.5 * df.balls_recoverd AS FLOAT) AS pt_br, cast(0.5 * df.tackles AS FLOAT) AS pt_tk, df.t_won AS pt_tw, cast(-0.5 * dc.fouls_committed AS FLOAT) as pt_fo, (-2 * dc.red) AS pt_rd, (-1 * dc.yellow) AS pt_yw
          FROM defending df 
          JOIN disciplinary dc ON dc.player_name = df.player_name
         WHERE df.position IN ('Midfielder', 'Defender')
           AND df.match_played > 5
  ) t
GROUP BY club, player_name)
SELECT club, sum(resultado) as resultado
  FROM dados_top_def
GROUP BY club
ORDER BY resultado DESC;

--3) Top atacantes
SELECT club, 
       player_name,
       sum(pt_ass) + sum(pt_off) + sum(pt_att) + sum(pt_ont) + sum(pt_gol) AS resultado 
  FROM (
        SELECT atk.club, atk.player_name, (2 * atk.assists) AS pt_ass, cast(-0.5 * atk.offsides AS FLOAT) AS pt_off, cast(0.5 * att.total_attempts AS FLOAT) AS pt_att, att.on_target AS pt_ont, (3 * g.goals) AS pt_gol
          FROM attacking atk 
          JOIN attempts att on att.player_name = atk.player_name 
          JOIN goals g on g.player_name = att.player_name
         WHERE atk.position in ('Midfielder', 'Forward')
           AND atk.match_played > 5
  ) t
GROUP BY club, player_name
ORDER BY resultado DESC;

WITH dados_top_atk AS (
    SELECT club, 
        player_name,
        sum(pt_ass) + sum(pt_off) + sum(pt_att) + sum(pt_ont) + sum(pt_gol) AS resultado 
    FROM (
          SELECT atk.club, atk.player_name, (2 * atk.assists) AS pt_ass, cast(-0.5 * atk.offsides AS FLOAT) AS pt_off, cast(0.5 * att.total_attempts AS FLOAT) as pt_att, att.on_target AS pt_ont, (3 * g.goals) AS pt_gol
            FROM attacking atk 
            JOIN attempts att ON att.player_name = atk.player_name 
            JOIN goals g ON g.player_name = att.player_name
           WHERE atk.position IN ('Midfielder', 'Forward')
             AND atk.match_played > 5
    ) t
    GROUP BY club, player_name)
SELECT club, sum(resultado) AS resultado
  FROM dados_top_atk 
GROUP BY club 
ORDER BY resultado DESC;