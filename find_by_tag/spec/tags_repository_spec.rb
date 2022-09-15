require "tags_repository"

def reset_posts_table
  seed_sql = File.read("spec/seeds.sql")
  connection = PG.connect({ host: "127.0.0.1", dbname: "blog_posts_tags" })
  connection.exec(seed_sql)
end

describe TagsRepository do
  before(:each) do
    reset_posts_table
  end

  it "rtetuens all tags with post id 1" do
    repo = TagsRepository.new

    tags = repo.find_by_post_id(1)

    expect(tags.length).to eq 1

    expect(tags[0].id).to eq 1
    expect(tags[0].name).to eq ("coding")
  end

  it "rtetuens all tags with post id 2" do
    repo = TagsRepository.new

    tags = repo.find_by_post_id(2)

    expect(tags.length).to eq 2

    expect(tags[0].id).to eq 1
    expect(tags[0].name).to eq ("coding")
    expect(tags[1].id).to eq 4
    expect(tags[1].name).to eq ("ruby")
  end
end
