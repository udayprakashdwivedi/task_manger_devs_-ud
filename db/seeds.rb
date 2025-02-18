# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


# Clear existing data to prevent duplicates
Task.destroy_all
User.destroy_all

# Create sample users
users = [
  { name: "uday", email: "uday@gmail.com", phone: "9993982808", status: "active", password: "password" }
]

users.each do |user_data|
  User.create!(user_data)
end

# get all users
all_users = User.all

# Create sample tasks for each user
all_users.each do |user|
  3.times do |i|
    Task.create!(
      title: "Task #{i + 1} for #{user.name}",
      description: "Description for task #{i + 1}",
      status: %w[pending in_progress completed].sample,
      due_date: Date.today + rand(1..10).days,
      user: user
    )
  end
end
