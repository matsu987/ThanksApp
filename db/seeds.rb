require "csv"

CSV.foreach('db/seeds/csv/thanks_app_user.csv', headers: true) do |row|
  User.create(
    name: row['name'],
    email: row['email'],
    introduction: row['introduction'],
    status: row['status'],
    password: row['password']
  )
end