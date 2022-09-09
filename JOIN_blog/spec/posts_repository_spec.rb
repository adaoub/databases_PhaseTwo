require "posts_repository"

def reset_posts_table
  seed_sql = File.read("spec/seeds.sql")
  connection = PG.connect({ host: "127.0.0.1", dbname: "blog" })
  connection.exec(seed_sql)
end

describe PostRepository do
  before(:each) do
    reset_posts_table
  end

  it "finds a post and its comments" do
    repo = PostRepository.new

    post = repo.find_with_comments(2)

    expect(post.id).to eq "2"
    expect(post.title).to eq "weather"
    expect(post.content).to eq "very warm"
    expect(post.comments.length).to eq 2
    expect(post.comments.first.content).to eq "I think its raining next week"
  end
end
