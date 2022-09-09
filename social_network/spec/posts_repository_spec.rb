require "posts_repository"

def reset_useraccounts_table
  seed_sql = File.read("spec/seeds.sql")
  connection = PG.connect({ host: "127.0.0.1", dbname: "social_network_test" })
  connection.exec(seed_sql)
end

describe PostsRepository do
  before(:each) do
    reset_useraccounts_table
  end

  it "returns all posts" do
    repo = PostsRepository.new

    post = repo.all

    # post.length # =>  1

    expect(post[0].title).to eq "Weather"
    expect(post[0].content).to eq "very warm"
    expect(post[0].views).to eq 200
    expect(post[0].user_account_id).to eq 1

    expect(post[1].title).to eq "books"
    expect(post[1].content).to eq "reading flow"
    expect(post[1].views).to eq 250
    expect(post[1].user_account_id).to eq 1
  end

  it "returns a single post" do
    repo = PostsRepository.new

    post = repo.find(1)

    expect(post.title).to eq "Weather"
    expect(post.content).to eq "very warm"
    expect(post.views).to eq 200
    expect(post.user_account_id).to eq 1
  end

  it "creates a post" do
    repo = PostsRepository.new

    # Build a new model object
    post = Posts.new
    post.title = "coding"
    post.content = "Learning to code"
    post.views = "500"
    post.user_account_id = 2

    repo.create(post) # Performs the INSERT query

    # Performs a SELECT query to get all records (implemented previously)
    find_post = repo.find(3)

    # all_useraccounts should contain the user_accounts 'molly' created above.

    expect(find_post.id).to eq "3"
    expect(find_post.title).to eq "coding"
    expect(find_post.content).to eq "Learning to code"
    expect(find_post.views).to eq 500
    expect(find_post.user_account_id).to eq 2
  end

  it "deletes a post" do
    repo = PostsRepository.new

    repo.delete(1)

    posts = repo.all

    expect(posts.length).to eq 1
    expect(posts[0].title).to eq "books"
    expect(posts[0].content).to eq "reading flow"
    expect(posts[0].views).to eq 250
    expect(posts[0].user_account_id).to eq 1
  end

  it "updates a post" do
    repo = PostsRepository.new

    find_post = repo.find(1)

    find_post.content = "very cold"
    find_post.views = 1000
    find_post.user_account_id = 2

    repo.update(find_post)

    posts = repo.all

    expect(posts[0].title).to eq "Weather"
    expect(posts[0].content).to eq "very cold"
    expect(posts[0].views).to eq 1000
    expect(posts[0].user_account_id).to eq 2
  end
end
