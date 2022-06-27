class CreateChats < ActiveRecord::Migration[7.0]
  def change
    create_table :chats, id: :integer do |t|
      t.integer :chat_type, null: false

      t.timestamps
    end
  end
end
