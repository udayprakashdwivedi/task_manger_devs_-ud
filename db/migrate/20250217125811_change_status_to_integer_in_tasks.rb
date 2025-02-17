class ChangeStatusToIntegerInTasks < ActiveRecord::Migration[6.1]
  def change
    change_column :tasks, :status, :integer, default: 0
  end
end
