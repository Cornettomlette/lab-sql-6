/*We are going to do some database maintenance. We have received the film catalog for 2020. 
We have just one item for each film, and all will be placed in store 2.
 All other movies will be moved to store 1. 
 The rental duration will be 3 days, with an offer price of 2.99€ and a replacement cost of 8.99€. 
The catalog is in a CSV file named films_2020.csv that can be found at files_for_lab folder.

Instructions
Add the new films to the database.
Update inventory.*/

USE sakila;
show variables like 'local_infile';
set global local_infile = 1;

SHOW VARIABLES LIKE "secure_file_priv";

load data infile '/mnt/c/Users/annil/Desktop/Data_studying/WEEK_2/lab-sql-6/files_for_lab/films_2020.csv'
into table film
fields terminated by ','
ENCLOSED BY '"'
LINES TERMINATED by '\n'
(title, description, release_year, language_id, @rental_rate, length, rating, special_features)
SET rental_rate = IF(@rental_rate = '', 0, @rental_rate);


select * from film order by film_id desc;

UPDATE film
SET replacement_cost = 8.99, rental_duration = 3
WHERE release_year = 2020;

UPDATE inventory
SET store_id = 1;

insert into inventory(film_id, store_id) 
select film_id, 2 from film where release_year = 2020;

select * from inventory order by film_id desc;
