# {{Social_Network}} Model and Repository Classes Design Recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

## 1. Design and create the Table

If the table is already created in the database, you can skip this step.

Otherwise, [follow this recipe to design and create the SQL schema for your table](./single_table_design_recipe_template.md).

*In this template, we'll use an example table `useraccounts`*

```
# EXAMPLE

Table: posts
 id |  title  |   content   
----+---------+-------------
  1 | Coding  | very hard
  2 | weather | very warm
  3 | time    | runni

Table: comments
 id |            content            | post_id 
----+-------------------------------+---------
  1 | Yeah I agree!                 |       1
  2 | I think its raining next week |       2
(2 rows)
```

## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
-- EXAMPLE
-- (file: spec/seeds_{table_name}.sql)

-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE posts, comments RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.


INSERT INTO posts (title, content)VALUES('Coding', 'very hard');


INSERT INTO posts (title, content)VALUES('weather', 'very warm');

INSERT INTO posts (title, content)VALUES('time', 'running out');


INSERT INTO comments (content, post_id) VALUES ('Yeah I agree!', 1);
INSERT INTO comments (content, post_id)VALUES ('I think its raining next week', 2);

```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 your_database_name < seeds_{table_name}.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# EXAMPLE
# Table name: Posts

# Model class
# (in lib/Posts.rb)
class Post
end

# Repository class
# (in lib/Posts_repository.rb)
class PostRepository
end

class Comments
end

class CommentsRepository
end
```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# EXAMPLE
# Table name: Posts

# Model class
# (in lib/Posts.rb)

class Post

  # Replace the attributes by your own columns.
  attr_accessor :id, :title, :content
end

# The keyword attr_accessor is a special Ruby feature
# which allows us to set and get attributes on an object,
# here's an example:
#
# Posts = Posts.new
# Posts.name = 'Bossanova'
# Posts.name

#2
# Table name: posts

class Comments

  # Replace the attributes by your own columns.
  attr_accessor :id, :content, :post_id
end

```


*You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.*

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# EXAMPLE
#1
# Table name: Posts

# Repository class
# (in lib/useraccounts_repository.rb)

class PostRepository

def find_with_comments (id)
 # Executes the SQL query:
  # SELECT posts.id AS post_id, posts.title, posts.content, comments.id AS comment_id, comments.content AS comment_content
  # FROM comments
  # JOIN posts ON comments.post_id = posts.id
  # WHERE post_id = 2;

   #return a post object with array of comment objects     
end



```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# EXAMPLES



# 1
# Get a post and it's asscciated comments


repo = PostRepository.new

post = repo.find_with_Posts(2)

post.id # =>  "1"
post.title # =>  "weather"
post.content # =>  'very warm'
post.comments.length # => 2
post.comments.first.comment_content # => "I think its raining next week"



```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/Posts_repository_spec.rb

def reset_cohorts_table
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'Post_directory_2' })
  connection.exec(seed_sql)
end

describe CohortsRepository do
  before(:each) do 
    reset_cohorts_table
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._

