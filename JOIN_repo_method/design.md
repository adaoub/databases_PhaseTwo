# {{Social_Network}} Model and Repository Classes Design Recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

## 1. Design and create the Table

If the table is already created in the database, you can skip this step.

Otherwise, [follow this recipe to design and create the SQL schema for your table](./single_table_design_recipe_template.md).

*In this template, we'll use an example table `useraccounts`*

```
# EXAMPLE

Table: students
 id | name | cohort_id 
----+------+-----------
  1 | Bob  |         1
  2 | John |         2
  3 | Lucy |         1
(3 rows)

Table: cohorts
 id |      name      | starting_date 
----+----------------+---------------
  1 | June 2000      | 2000-04-20
  2 | September 2022 | 2022-09-15
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

TRUNCATE TABLE students RESTART IDENTITY; -- replace with your own table name.
TRUNCATE TABLE cohorts RESTART IDENTITY;
-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO "public"."students" ("name") VALUES
('Bob');

INSERT INTO "public"."students" ("name") VALUES
('John');

INSERT INTO "public"."students" ("name") VALUES
('Lucy');

INSERT INTO "public"."cohorts" ("name", "strating_date") VALUES
('September 2022', 15/09/2022);

INSERT INTO "public"."cohorts" ("name", "strating_date") VALUES
('June 2000', 15/06/2000);



```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 your_database_name < seeds_{table_name}.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# EXAMPLE
# Table name: user_accounts

# Model class
# (in lib/user_accounts.rb)
class UserAccount
end

# Repository class
# (in lib/user_accounts_repository.rb)
class UserAccountRepository
end
```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# EXAMPLE
# Table name: user_accounts

# Model class
# (in lib/user_accounts.rb)

class UserAccount

  # Replace the attributes by your own columns.
  attr_accessor :id, :email, :username,
end

# The keyword attr_accessor is a special Ruby feature
# which allows us to set and get attributes on an object,
# here's an example:
#
# user_accounts = user_accounts.new
# user_accounts.name = 'Bossanova'
# user_accounts.name

#2
# Table name: posts

class Posts

  # Replace the attributes by your own columns.
  attr_accessor :id, :title, :content, :views, :user_account_id
end

```


*You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.*

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# EXAMPLE
#1
# Table name: user_accounts

# Repository class
# (in lib/useraccounts_repository.rb)

class UserAccountRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, email, username FROM user_accounts;

    # Returns an array of user_accounts objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, email, username FROM user_accounts WHERE id = $1;

    # Returns a single user_accounts object.
  end

  # Add more methods below for each operation you'd like to implement.

  def create(account)
  # Executes the SQL query:
  #INSERT INTO user_accounts (email, username) VALUES ($1, $2);
  
  #returns nothing
  end

  def update(account)

  #Executes the SQL query:
  # UPDATE user_accounts SET email = $1, username = $2;

  #returns nothing

  end

  def delete(id)
  # Execute the SQL query:
  #DELETE FROM user_accounts WHERE id = $1
  #returns nothing
  end
end


#2 Posts table

class PostsRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, title, content, views, user_account_id FROM posts;

    # Returns an array of posts objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, title, content, views, user_account_id FROM posts WHERE id = $1;

    # Returns a single user_accounts object.
  end

  # Add more methods below for each operation you'd like to implement.

  def create(post)
  # Executes the SQL query:
  #INSERT INTO posts (title, content, views, user_account_id) VALUES ($1, $2, $3, $4);
  
  #returns nothing
  end

  def update(post)

  #Executes the SQL query:
  # UPDATE posts SET title = $1, content = $2, views = $3, user_account_id = $4;

  #returns nothing

  end

  def delete(id)
  # Execute the SQL query:
  #DELETE FROM posts WHERE id = $1
  #returns nothing
  end
end


```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# EXAMPLES

### user_account classes

# 1
# Get all user_accounts

repo = UserAccountRepository.new

user_accounts = repo.all

# user_accounts.length # =>  1

user_accounts[0].id # =>  1
user_accounts[0].email # =>  'test@gmail.com'
user_accounts[0].username # =>  'test01'

user_accounts[1].id # =>  2
user_accounts[1].email # =>  'rob@gmail.com'
user_accounts[1].username # =>  'Rob'





# 2
# Get a single user_accounts


repo = UserAccountRepository.new

user_accounts = repo.find(1)

user_accounts.id # =>  1
user_accounts.email # =>  'test@gmail.com'
user_accounts.username # =>  'test01'




# 3
# create an user_accounts

repo = UserAccountRepository.new

# Build a new model object
user_account = UserAccount.new
user_account.email = 'molly@gmail.com'
user_account.username = 'molly'


repo.create(user_account) # Performs the INSERT query

# Performs a SELECT query to get all records (implemented previously)
user_accounts = repo.all 

# all_useraccounts should contain the user_accounts 'molly' created above.
user_accounts[0].id # =>  1
user_accounts[0].email # =>  'test@gmail.com'
user_accounts[0].username # =>  'test01'

user_accounts[1].id # =>  2
user_accounts[1].email # =>  'rob@gmail.com'
user_accounts[1].username # =>  'Rob'

user_accounts[2].id # =>  3
user_accounts[2].email # =>  'molly@gmail.com'
user_accounts[2].username # =>  'molly'


# 4
# Delete a single user_accounts


repo = UserAccountRepository.new



repo.delete(1)

useraccounts = repo.all

useraccounts.length #=>1



#5 update an user_accounts record

repo = UserAccountRepository.new

user_account = repo.find(1)

user_account.email = "max@yahoo.com"
user_account.username = "max"


repo.update(user_account)

useraccounts = repo.all

useraccounts[0].email #> "max@yahoo.com"
useraccounts[0].username #> "max


#-----------------------------------------------------------------------------------------

### Posts classes

# 1
# Get all posts

repo = PostsRepository.new

post = repo.all

# post.length # =>  1

post[0].title #-> "Weather" 
post[0].content  #-> "very warm"
post[0].views  #-> 200
posts[0].user_account_id #-> 1

post[1].title  #-> "books"
post[1].content #-> "reading flow"
post[1].views  #-> 250
posts[1].user_account_id #-> 1

# 2
# Get a single post


repo = PostsRepository.new

post = repo.find(1)

post.title # =>  "Weather"
post.content # =>  "very warm"
post.views # =>  200
post.user_account_id #-> 1




# 3
# create a post

repo = PostsRepository.new

# Build a new model object
post = Post.new
post.title = "coding"
post.content = 'Learning to code'
post.views = "500"
post.user_account_id = 2


repo.create(post) # Performs the INSERT query

# Performs a SELECT query to get all records (implemented previously)
find_post = repo.find(3) 

# all_useraccounts should contain the user_accounts 'molly' created above.

find_post.id # =>  3
find_post.title # =>  "coding"
find_post.content # =>  'Learning to code'
find_post.views #-> 500
find_post.user_account_id #-> 2


# 4
# Delete a single user_accounts


repo = PostsRepository.new



repo.delete(1)

posts = repo.all

posts.length #=>1



#5 update an user_accounts record

repo = PostsRepository.new

find_post = repo.find(1)

find_post.content = "very cold"
find_post.views = 1000
find_post.user_account_id = 2


repo.update(find_post)

posts = repo.all

posts[0].title #> "weather"
posts[0].content #> "very cold"
posts[0].views #> 2
posts[0].user_account_id #-> 2



```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/user_accounts_repository_spec.rb

def reset_useraccounts_table
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
  connection.exec(seed_sql)
end

describe user_accountsRepository do
  before(:each) do 
    reset_useraccounts_table
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._

