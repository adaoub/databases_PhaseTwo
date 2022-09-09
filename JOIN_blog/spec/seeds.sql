TRUNCATE TABLE posts, comments RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.


INSERT INTO posts (title, content)VALUES('Coding', 'very hard');


INSERT INTO posts (title, content)VALUES('weather', 'very warm');

INSERT INTO posts (title, content)VALUES('time', 'running out');


INSERT INTO comments (content, post_id) VALUES ('Yeah I agree!', 1);
INSERT INTO comments (content, post_id)VALUES ('I think its raining next week', 2);
INSERT INTO comments (content, post_id)VALUES ('I do like it warm', 2);