SELECT * FROM blog_user bu 


-- Data Manipulation Language (DML)

-- Adding rows to a table 
-- Syntax: INSERT INTO table_name(col_name1, col_name2, etc) VALUES (val_1, val_2, etc)

INSERT INTO blog_user(
	username,
	pw_hash,
	first_name,
	last_name,
	email_address
) VALUES (
	'brians',
	'sakhgdkjdguhsrtkjr',
	'Brian',
	'Stanton',
	'brians@ct.com'
);

SELECT * FROM blog_user bu 

-- Insert another user
-- Order of the columns matter!

INSERT INTO blog_user(
	first_name,
	last_name,
	email_address,
	username,
	pw_hash 
) VALUES (
	'Travis',
	'Peck',
	'travisp@ct.com',
	'travisp',
	'sakhlgkhkjlfsaf'
);

SELECT * FROM blog_user bu 

-- Insert Values Only
-- Syntax: INSERT INTO table_name VALUES (val_1, val_2, etc)
-- Values follow the original order that the columns were added 

SELECT * FROM category c;

INSERT INTO category VALUES (
	1, -- have TO manually enter things that may typically be DEFAULT, LIKE the category_id (bcuz position matters)
	'Programming',
	'Making cool programs with cool languages'
);

SELECT * FROM category c ;

-- Because we added the first category with the manual entry of category_id = 1, the serial 
-- default did not call nextval on the sequence. So, when we try to create a new category
-- using the default, it will *initially* throw an error

INSERT INTO category(
	category_name,
	description
) VALUES (
	'Health & Fitness',
	'Get that body moving!'
);

-- SQL Error [23505]: ERROR: duplicate key value violates unique constraint "category_pkey"
--   Detail: Key (category_id)=(1) already exists.
-- When you execute again, the nextval will no longer be 1, it will be 2, so it will not add. 

SELECT * FROM category c;

-- Insert Multiple Rows at a time
-- Syntax: you could just use values, but we'll use the columns as well
-- INSERT INTO table_name (col_1, col_2, etc) VALUES (val_a_1, val_a_2, etc), (val_b_1, val_b_2, etc)

SELECT * FROM blog_user bu ;
SELECT * FROM post;

INSERT INTO post (
	title,
	body,
	user_id
) VALUES (
	'Hello World',
	'This is the first post that we are making today!',
	1	
), (
	'March Madness',
	'Who do you have winning the national championship?',
	2
), (
	'Spring',
	'Spring has sprung. Yesterday was the vernal equinox',
	2
);

SELECT * FROM post;

-- If you try to add a post with a user who doesn't exist, it will throw an error 


-- To Update existing data in a table
-- Syntax: Update table_name SET col_1 = val_1, col_2 = val_2 WHERE condition

-- User with the ID of 1 wants to change the username to 'bstanton'
UPDATE blog_user 
SET username = 'bstanton'
WHERE user_id = 1;

SELECT * FROM blog_user bu;

SELECT * FROM blog_user bu 
WHERE username LIKE '%i%;'

UPDATE blog_user
SET last_name = 'ABC'
WHERE username LIKE '%i%';

SELECT * FROM blog_user bu;

-- Set Multiple Columns in one command 
SELECT * FROM post p;

UPDATE post 
SET title = 'Goodbye World', body = 'The title makes this kind of depressing'
WHERE post_id = 1;

-- Alter the category table and add a color column 
ALTER TABLE category 
ADD COLUMN color VARCHAR(7); 

SELECT * FROM category c;

-- An UPDATE/SET without a WHERE will update ALL ROWS
UPDATE category 
SET color = '#2121b0';

-- 90% of the time, you will want a WHERE with your UPDATE/SET 

-- DELETE data from a table
-- Syntax: DELETE FROM table_name WHERE condition 
-- WHERE is not required but it is HIGHLY RECOMMENDED 
-- *** Without a WHERE, EVERY ROW WILL BE DELETED ***

SELECT * FROM post p;
DELETE FROM post 
WHERE post_id = 1;


-- if you wanted to delete the entire TABLE and not just all the values within the table, that would be a DROP

SELECT title, first_name, last_name, p.user_id
FROM blog_user bu 
JOIN post p 
ON b.user_id = p.user_id;


-- TO DELETE SOMETHING THAT HAS OTHER VALS TIED TO IT
-- Delete a user that has a post
DELETE FROM blog_user 
WHERE user_id = 2; -- this will throw an err because the USER_id still EXISTS 

-- To make it so that when we delete a row, it will delete any rows in related tables 
-- that reference this row, we will add ON DELETE CASCADE to foreign key constraint 

-- First, you must drop the foreign key constraint on post
ALTER TABLE post 
DROP CONSTRAINT post_user_id_fkey;

-- Then, add the foreign key back with the ON DELETE 
ALTER TABLE post 
ADD FOREIGN KEY(user_id) REFERENCES blog_user(user_id) ON DELETE CASCADE;

SELECT * FROM blog_user bu;
SELECT * FROM post;
-- Delete a user that has a post
DELETE FROM blog_user 
WHERE user_id = 2;

SELECT * FROM blog_user bu;
SELECT * FROM post p;
DELETE FROM blog_user 
WHERE user_id = 2; 