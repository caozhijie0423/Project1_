set hive.cli.print.header=true;
set hive.resultset.use.unique.column.names=false;
--CREATE DATABASE
create database project
comment 'For Project'
location '/user/hive/warehouse';

show create database project;
--CREATE TABLE
create table ratings(
    id int,
    movieid int,
    ratings int,
    datet string)
    ROW FORMAT DELIMITED
    FIELDS TERMINATED BY ','
    stored as textfile;

--Upload your document to hadoop
hdfs dfs -put /Users/caozhijie/Downloads/ratings.txt hdfs://localhost:9000/user/hive/warehouse
LOAD DATA INPATH '/user/hive/warehouse/ratings.txt' INTO TABLE ratings;

--insert daya using python
INSERT OVERWRITE TABLE ratings2
SELECT TRANSFORM (id, movieid, ratings, datet) USING 'python modifytime.py' AS (userid, movieid, rating, weekday) 
FROM ratings;


-- create table using complicated datatypes
create table datatype(name string,score map<string,int> ,address array<string>,info struct<age:int>) ROW FORMAT DELIMITED 
FIELDS TERMINATED BY ','
collection items terminated by'|'
map keys terminated by ':' 
stored as textfile
