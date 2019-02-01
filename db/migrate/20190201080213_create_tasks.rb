class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :content
      t.string :priority
      t.datetime :endtime
      t.string :status
      t.text :tags
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
