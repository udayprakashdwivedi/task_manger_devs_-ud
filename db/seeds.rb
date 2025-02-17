# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end




User.create!(
  name: "Uday",
  email: "udaytest@gmail.com",
  phone: "1234567890",
  status: "active",
  password: "password"
)

Task.create!(
  title: "Sample Task",
  description: "This is a first task",
  status: "pending",
  due_date: Date.today + 7.days,
  user: User.first
)
