class CreateTasks < ActiveRecord::Migration[8.0]
  def change
    create_table :tasks do |t|
      t.string "title"
      t.text "description"
      t.integer "status", default: 0
      t.date "due_date"
      t.bigint "user_id", null: false
      t.timestamps
    end
  end
end
