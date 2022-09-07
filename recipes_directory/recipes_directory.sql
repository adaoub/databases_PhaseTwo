DROP TABLE IF EXISTS "public"."recipes";
-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS recipes_id_seq;

-- Table Definition
CREATE TABLE "public"."recipes" (
    "id" SERIAL,
    "name" text,
    "cooking_time" int,
    "rating" int,
    PRIMARY KEY ("id")
);

INSERT INTO "public"."recipes" ("name", "cooking_time", "rating") VALUES
('rice', 20, 5),
('pasta', 30, 4),
('chips', 30, 3),
('fish', 60, 2),
('lamb', 80, 1);