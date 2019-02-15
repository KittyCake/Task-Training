class RemoveTagsFromTasks < ActiveRecord::Migration[5.2]
  def change
    remove_column :tasks, :tags
  end
end
