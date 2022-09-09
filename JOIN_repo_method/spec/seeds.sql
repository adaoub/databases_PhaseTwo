TRUNCATE TABLE cohorts, students RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.


INSERT INTO "public"."cohorts" ("name", "starting_date") VALUES
('September 2022', '2022/09/15');


INSERT INTO "public"."cohorts" ("name", "starting_date") VALUES
('June 2000', '2000/06/20');


INSERT INTO "public"."students" ("name", "cohort_id") VALUES
('Bob', 1);

INSERT INTO "public"."students" ("name", "cohort_id") VALUES
('John', 2);

INSERT INTO "public"."students" ("name", "cohort_id") VALUES
('Lucy', 1);