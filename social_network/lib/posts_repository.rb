require "./lib/posts"

class PostsRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    query = "SELECT id, title, content, views, user_account_id FROM posts;"
    result = DatabaseConnection.exec_params(query, [])

    array = []

    result.each do |accounts|
      post = Posts.new

      post.id = accounts["id"]
      post.title = accounts["title"]
      post.content = accounts["content"]
      post.views = accounts["views"].to_i
      post.user_account_id = accounts["user_account_id"].to_i

      array << post
    end
    return array

    # Returns an array of posts objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    query = "SELECT id, title, content, views, user_account_id FROM posts WHERE id = $1;"
    params = [id]
    result = DatabaseConnection.exec_params(query, params)
    accounts = result[0]
    post = Posts.new

    post.id = accounts["id"]
    post.title = accounts["title"]
    post.content = accounts["content"]
    post.views = accounts["views"].to_i
    post.user_account_id = accounts["user_account_id"].to_i

    return post

    # Returns a single user_accounts object.
  end

  # Add more methods below for each operation you'd like to implement.

  def create(post)
    # Executes the SQL query:
    query = "INSERT INTO posts (title, content, views, user_account_id) VALUES ($1, $2, $3, $4);"
    params = [post.title, post.content, post.views, post.user_account_id]

    result = DatabaseConnection.exec_params(query, params)
    #returns nothing
  end

  def update(post)

    #Executes the SQL query:
    query = "UPDATE posts SET title = $1, content = $2, views = $3, user_account_id = $4;"
    params = [post.title, post.content, post.views, post.user_account_id]

    result = DatabaseConnection.exec_params(query, params)

    #returns nothing

  end

  def delete(id)
    # Execute the SQL query:
    query = "DELETE FROM posts WHERE id = $1;"
    params = [id]
    result = DatabaseConnection.exec_params(query, params)
    #returns nothing
  end
end
