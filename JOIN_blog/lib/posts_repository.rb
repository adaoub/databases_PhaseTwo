require "./lib/post"
require "./lib/comments"

class PostRepository
  def find_with_comments(id)
    # Executes the SQL query:
    query = "SELECT posts.id AS post_id, posts.title, posts.content, comments.id AS comment_id, comments.content AS comment_content
     FROM comments
     JOIN posts ON comments.post_id = posts.id
     WHERE post_id = $1;"

    params = [id]

    result = DatabaseConnection.exec_params(query, params)

    post = Post.new
    post.id = result.first["post_id"]
    post.title = result.first["title"]
    post.content = result.first["content"]

    result.each do |record|
      comment = Comments.new
      comment.id = record["comment_id"]
      comment.content = record["comment_content"]

      post.comments << comment
    end

    p post

    return post
    # result.each do |record|
    #   p record
    # end
    #return a post object with array of comment objects
  end
end
