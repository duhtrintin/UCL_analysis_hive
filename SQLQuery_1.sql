--media gols jogador
select att.player_name, 
       att.total_attempts, 
       g.goals,
       (CAST(g.goals AS float) / att.total_attempts) as mean_goals
  from attempts att
  join goals g on g.player_name = att.player_name;

--media de gols por time 
select club,
       total_attempts,
       total_goals,
       (CAST(total_goals AS float) / total_attempts) as mean_goals_club
  from (
    select att.club, 
        sum(att.total_attempts) as total_attempts, 
        sum(g.goals) as total_goals
    from attempts att 
    join goals g on g.club = att.club
    group by att.club
  ) t;

--top defensores
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

--top defensores global
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

--top atacantes
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

--top atacantes global
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

  







