require "./lib/user_account"

class UserAccountRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    query = "SELECT id, email, username FROM user_accounts;"
    result = DatabaseConnection.exec_params(query, [])

    array = []

    result.each do |accounts|
      user_account = UserAccount.new
      user_account.id = accounts["id"]
      user_account.email = accounts["email"]
      user_account.username = accounts["username"]

      array << user_account
    end
    return array
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    query = "SELECT id, email, username FROM user_accounts WHERE id = $1;"
    params = [id]
    result = DatabaseConnection.exec_params(query, params)
    account = result[0]

    user_account = UserAccount.new
    user_account.id = account["id"]
    user_account.email = account["email"]
    user_account.username = account["username"]

    return user_account
    # Returns a single user_accounts object.
  end

  # Add more methods below for each operation you'd like to implement.

  def create(account)
    # Executes the SQL query:
    query = "INSERT INTO user_accounts (email, username) VALUES ($1, $2);"

    params = [account.email, account.username]

    result = DatabaseConnection.exec_params(query, params)

    #returns nothing
  end

  def update(account)

    #Executes the SQL query:
    query = "UPDATE user_accounts SET email = $1, username = $2;"
    params = [account.email, account.username]
    result = DatabaseConnection.exec_params(query, params)

    #returns nothing

  end

  def delete(id)
    #Execute the SQL query:
    query = "DELETE FROM user_accounts WHERE id = $1"
    params = [id]
    result = DatabaseConnection.exec_params(query, params)
    #returns nothing
  end
end
