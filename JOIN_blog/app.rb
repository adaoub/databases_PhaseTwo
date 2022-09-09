require_relative "./lib/database_connection"
require_relative "./lib/posts_repository"

DatabaseConnection.connect("blog")

posts_repository = PostRepository.new

result = posts_repository.find_with_comments(2)

result.comments.each do |post|
  p result.id
  p result.title
  p result.content
  p post.id
  p post.content
end
