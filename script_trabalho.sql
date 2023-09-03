CREATE TABLE attacking (
    serial INT,
    player_name STRING,
    club STRING,
    position STRING,
    assists INT,
    corner_taken INT,
    offsides INT,
    dribbles INT,
    match_played INT
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
TBLPROPERTIES ("skip.header.line.count"="1");

LOAD DATA INPATH '/user/duh_trintin/datasets/attacking.csv' INTO TABLE attacking;

CREATE TABLE attempts (
    serial INT,
    player_name STRING,
    club STRING,
    position STRING,
    total_attempts INT,
    on_target INT,
    off_target INT,
    blocked INT,
    match_played INT
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
TBLPROPERTIES ("skip.header.line.count"="1");

LOAD DATA INPATH '/user/duh_trintin/datasets/attempts.csv' INTO TABLE attempts;

CREATE TABLE defending (
    serial INT,
    player_name STRING,
    club STRING,
    position STRING,
    balls_recoverd INT,
    tackles INT,
    t_won INT,
    t_lost INT,
    clearance_attempted INT,
    match_played INT
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
TBLPROPERTIES ("skip.header.line.count"="1");

LOAD DATA INPATH '/user/duh_trintin/datasets/defending.csv' INTO TABLE defending;

CREATE TABLE disciplinary (
    serial INT,
    player_name STRING,
    club STRING,
    position STRING,
    fouls_committed INT,
    fouls_suffered INT,
    red INT,
    yellow INT,
    minutes_played INT,
    match_played INT
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
TBLPROPERTIES ("skip.header.line.count"="1");

LOAD DATA INPATH '/user/duh_trintin/datasets/disciplinary.csv' INTO TABLE disciplinary;

CREATE TABLE distributon (
    serial INT,
    player_name STRING,
    club STRING,
    position STRING,
    pass_accuracy FLOAT,
    pass_attempted INT,
    pass_completed INT,
    cross_accuracy FLOAT,
    cross_attempted INT,
    cross_complted INT,
    freekicks_taken INT,
    match_played INT
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
TBLPROPERTIES ("skip.header.line.count"="1");

LOAD DATA INPATH '/user/duh_trintin/datasets/distributon.csv' INTO TABLE distributon;

CREATE TABLE goalkeeping (
    serial INT,
    player_name STRING,
    club STRING,
    position STRING,
    saved INT,
    conceded INT,
    saved_penalties INT,
    cleansheets INT,
    punches_made INT,
    match_played INT
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
TBLPROPERTIES ("skip.header.line.count"="1");

LOAD DATA INPATH '/user/duh_trintin/datasets/goalkeeping.csv' INTO TABLE goalkeeping;


CREATE TABLE key_stats (
    player_name STRING,
    club STRING,
    position STRING,
    minutes_played INT,
    match_played INT,
    goals INT,
    assists INT,
    distance_covered FLOAT
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
TBLPROPERTIES ("skip.header.line.count"="1");

LOAD DATA INPATH '/user/duh_trintin/datasets/key_stats.csv' INTO TABLE key_stats;

CREATE TABLE goals (
    serial INT,
    player_name STRING,
    club STRING,
    position STRING,
    goals INT,
    right_foot INT,
    left_foot INT,
    headers INT,
    others INT,
    inside_area INT,
    outside_areas INT,
    penalties INT,
    match_played INT
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
TBLPROPERTIES ("skip.header.line.count"="1");

LOAD DATA INPATH '/user/duh_trintin/datasets/goals.csv' INTO TABLE goals;
