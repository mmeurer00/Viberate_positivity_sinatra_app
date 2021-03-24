class Follows < ActiveRecord::Migration[6.0]
  def change
    create_table :follows do |t|
      t.integer :user_id
      t.integer :following_id
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
    end
  end
end
