class CreateConversations < ActiveRecord::Migration[5.0]
  def change
    create_table :conversations do |t|
      t.references :user_1, references: :users
      t.references :user_2, references: :users

      t.boolean :user_1_unread
      t.boolean :user_2_unread

      t.timestamps
    end
  end
end
