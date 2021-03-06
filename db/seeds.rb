# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

users = [
  {
    first_name: 'Daniele',
    last_name: 'P',
    email: ENV['ADMIN_EMAIL'],
    password: 'test1234',
    admin: true
  },
  {
    first_name: 'Tom',
    last_name: 'Clancy',
    email: 'test@test.com',
    password: 'test1234',
    admin: false
  }
]

users.each do |user|
  u = User.new(
    first_name: user[:first_name],
    last_name: user[:last_name],
    email: user[:email],
    password: user[:password],
    password_confirmation: user[:password]
  )
  u.role = :admin if user[:admin]
  u.save
end
