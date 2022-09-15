require "post"

class PostsRepository
  def find_by_tag(tag)
    # sql query:
    query = "SELECT posts.id, posts.title
      FROM posts
      JOIN posts_tags ON posts_tags.post_id = posts.id
      JOIN tags ON posts_tags.tag_id = tags.id
      WHERE tags.name = $1;"

    params = [tag]

    result = DatabaseConnection.exec_params(query, params)

    post_array = []
    result.each do |record|
      post = Posts.new
      post.id = record["id"].to_i
      post.title = record["title"]
      post_array << post
    end

    post_array

    #returns an array of posts that have that tag
  end
end
