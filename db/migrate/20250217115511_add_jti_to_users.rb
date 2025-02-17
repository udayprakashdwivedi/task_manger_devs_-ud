class AddJtiToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :jti, :string
    add_index :users, :jti, unique: true

    # Generate a unique JTI for existing users
    User.reset_column_information
    User.find_each { |user| user.update_column(:jti, SecureRandom.uuid) }

    # Set NOT NULL constraint
    change_column_null :users, :jti, false
  end
end
