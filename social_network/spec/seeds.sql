TRUNCATE TABLE user_accounts, posts RESTART IDENTITY; -- replace with your own table name.
-- TRUNCATE TABLE posts RESTART IDENTITY;
-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO "public"."user_accounts" ("email", "username") VALUES
('test@gmail.com', 'test01');

INSERT INTO "public"."user_accounts" ("email", "username") VALUES
('rob@gmail.com', 'Rob');

INSERT INTO "public"."posts" ("title", "content", "views", "user_account_id") VALUES
('Weather', 'very warm', 200, 1);

INSERT INTO "public"."posts" ("title", "content", "views", "user_account_id") VALUES
('books', 'reading flow', 250, 1);
