require "posts_repository"

def reset_posts_table
  seed_sql = File.read("spec/seeds.sql")
  connection = PG.connect({ host: "127.0.0.1", dbname: "blog_posts_tags" })
  connection.exec(seed_sql)
end

describe PostsRepository do
  before(:each) do
    reset_posts_table
  end

  it "rtetuens all posts with a coding tag" do
    repo = PostsRepository.new

    posts = repo.find_by_tag("coding")

    expect(posts.length).to eq 4

    expect(posts[0].id).to eq 1
    expect(posts[0].title).to eq ("How to use Git")

    expect(posts[1].id).to eq 2
    expect(posts[1].title).to eq ("Ruby classes")
  end

  it "rtetuens all posts with a travel" do
    repo = PostsRepository.new

    posts = repo.find_by_tag("travel")

    expect(posts.length).to eq 2

    expect(posts[0].id).to eq 4
    expect(posts[0].title).to eq ("My weekend in Edinburgh")

    expect(posts[1].id).to eq 6
    expect(posts[1].title).to eq ("A foodie week in Spain")
  end
end
