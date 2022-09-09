require "user_accounts_repository"

def reset_useraccounts_table
  seed_sql = File.read("spec/seeds.sql")
  connection = PG.connect({ host: "127.0.0.1", dbname: "social_network_test" })
  connection.exec(seed_sql)
end

describe UserAccountRepository do
  before(:each) do
    reset_useraccounts_table
  end

  it "returns all user_acounts" do
    repo = UserAccountRepository.new

    user_accounts = repo.all
    expect(user_accounts[0].id).to eq "1"
    expect(user_accounts[0].email).to eq "test@gmail.com"
    expect(user_accounts[0].username).to eq "test01"

    expect(user_accounts[1].id).to eq "2"
    expect(user_accounts[1].email).to eq "rob@gmail.com"
    expect(user_accounts[1].username).to eq "Rob"
  end

  it "returns a single user_account" do
    repo = UserAccountRepository.new

    user_accounts = repo.find(1)

    expect(user_accounts.id).to eq "1"
    expect(user_accounts.email).to eq "test@gmail.com"
    expect(user_accounts.username).to eq "test01"
  end

  it "create a user_account" do
    repo = UserAccountRepository.new

    # Build a new model object
    user_account = UserAccount.new
    user_account.email = "molly@gmail.com"
    user_account.username = "molly"

    repo.create(user_account) # Performs the INSERT query

    # Performs a SELECT query to get all records (implemented previously)
    user_accounts = repo.all

    # all_useraccounts should contain the user_accounts 'molly' created above.
    expect(user_accounts[0].id).to eq "1" # =>  1
    expect(user_accounts[0].email).to eq "test@gmail.com"
    expect(user_accounts[0].username).to eq "test01"

    expect(user_accounts[1].id).to eq "2"
    expect(user_accounts[1].email).to eq "rob@gmail.com"
    expect(user_accounts[1].username).to eq "Rob"

    expect(user_accounts[2].id).to eq "3"
    expect(user_accounts[2].email).to eq "molly@gmail.com"
    expect(user_accounts[2].username).to eq "molly"
  end
  it "create a user_account and find it" do
    repo = UserAccountRepository.new

    # Build a new model object
    user_account = UserAccount.new
    user_account.email = "molly@gmail.com"
    user_account.username = "molly"

    repo.create(user_account) # Performs the INSERT query

    # Performs a SELECT query to get all records (implemented previously)
    user_accounts = repo.find(3)

    # all_useraccounts should contain the user_accounts 'molly' created above.
    expect(user_accounts.id).to eq "3"
    expect(user_accounts.email).to eq "molly@gmail.com"
    expect(user_accounts.username).to eq "molly"
  end

  it "deletes a user_account" do
    repo = UserAccountRepository.new
    repo.delete(1)
    useraccounts = repo.all
    expect(useraccounts.length).to eq 1
  end

  it "updates a user_account" do
    repo = UserAccountRepository.new

    user_account = repo.find(1)

    user_account.email = "max@yahoo.com"
    user_account.username = "max"

    repo.update(user_account)

    useraccounts = repo.all

    expect(useraccounts[0].email).to eq "max@yahoo.com"
    expect(useraccounts[0].username).to eq "max"
  end

  it "updates a user_account and find it" do
    repo = UserAccountRepository.new

    user_account = repo.find(2)

    user_account.email = "max@yahoo.com"
    user_account.username = "max"

    repo.update(user_account)

    useraccounts = repo.find(2)

    expect(useraccounts.email).to eq "max@yahoo.com"
    expect(useraccounts.username).to eq "max"
  end
end
