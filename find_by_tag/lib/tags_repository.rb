require "tags"

class TagsRepository
  def find_by_post_id(id)
    # sql query:
    query = "SELECT tags.id, tags.name
      FROM posts
      JOIN posts_tags ON posts_tags.post_id = posts.id
      JOIN tags ON posts_tags.tag_id = tags.id
      WHERE posts.id = $1;"

    params = [id]

    result = DatabaseConnection.exec_params(query, params)

    tags_array = []
    result.each do |record|
      tag = Tags.new
      tag.id = record["id"].to_i
      tag.name = record["name"]
      tags_array << tag
    end

    tags_array

    #returns an array of posts that have that tag
  end
end
