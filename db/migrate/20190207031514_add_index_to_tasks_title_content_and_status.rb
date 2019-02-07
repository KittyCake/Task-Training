class AddIndexToTasksTitleContentAndStatus < ActiveRecord::Migration[5.2]
  def change
    add_index :tasks, [:title, :content], where: "(title IS NOT NULL) AND (content IS NOT NULL)", length: { title: 20, content: 60 }
    add_index :tasks, :status, where: 'status IS NOT NULL'
  end
end
