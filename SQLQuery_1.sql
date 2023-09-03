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
select club, player_name, sum(pt_br) + sum(pt_tk) + sum(pt_tw) +  sum(pt_fo) + sum(pt_rd) + sum(pt_yw) as resultado
  from (
        select dc.club, dc.player_name, cast(0.5 * df.balls_recoverd as float) as pt_br, cast(0.5 * df.tackles as float) as pt_tk, df.t_won as pt_tw, cast(-0.5 * dc.fouls_committed as float) as pt_fo, (-2 * dc.red) as pt_rd, (-1 * dc.yellow) as pt_yw
          from defending df 
        join disciplinary dc on dc.player_name = df.player_name
        where df.position in ('Midfielder', 'Defender')
          and df.match_played > 5
  ) t
group by club, player_name
order by resultado desc;

--top defensores global
with dados_top_def as (
select club, player_name, sum(pt_br) + sum(pt_tk) + sum(pt_tw) +  sum(pt_fo) + sum(pt_rd) + sum(pt_yw) as resultado
  from (
        select dc.club, dc.player_name, cast(0.5 * df.balls_recoverd as float) as pt_br, cast(0.5 * df.tackles as float) as pt_tk, df.t_won as pt_tw, cast(-0.5 * dc.fouls_committed as float) as pt_fo, (-2 * dc.red) as pt_rd, (-1 * dc.yellow) as pt_yw
          from defending df 
        join disciplinary dc on dc.player_name = df.player_name
        where df.position in ('Midfielder', 'Defender')
          and df.match_played > 5
  ) t
group by club, player_name)
select club, sum(resultado) as resultado
  from dados_top_def
group by club
order by resultado desc;

--top atacantes
select club, 
       player_name,
       sum(pt_ass) + sum(pt_off) + sum(pt_att) + sum(pt_ont) + sum(pt_gol) as resultado 
  from (
        select atk.club, atk.player_name, (2 * atk.assists) as pt_ass, cast(-0.5 * atk.offsides as float) as pt_off, cast(0.5 * att.total_attempts as float) as pt_att, att.on_target as pt_ont, (3 * g.goals) as pt_gol
        from attacking atk 
        join attempts att on att.player_name = atk.player_name 
        join goals g on g.player_name = att.player_name
       where atk.position in ('Midfielder', 'Forward')
         and atk.match_played > 5
  ) t
group by club, player_name
order by resultado desc;

--top atacantes global
with dados_top_atk as (
    select club, 
        player_name,
        sum(pt_ass) + sum(pt_off) + sum(pt_att) + sum(pt_ont) + sum(pt_gol) as resultado 
    from (
            select atk.club, atk.player_name, (2 * atk.assists) as pt_ass, cast(-0.5 * atk.offsides as float) as pt_off, cast(0.5 * att.total_attempts as float) as pt_att, att.on_target as pt_ont, (3 * g.goals) as pt_gol
            from attacking atk 
            join attempts att on att.player_name = atk.player_name 
            join goals g on g.player_name = att.player_name
        where atk.position in ('Midfielder', 'Forward')
            and atk.match_played > 5
    ) t
    group by club, player_name)
select club, sum(resultado) as resultado
  from dados_top_atk 
group by club 
order by resultado desc;

  







