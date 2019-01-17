class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :body
      t.text :thumb
      t.string :slug
      t.integer :status
      t.boolean :deleted
      t.string :postable_type
      t.integer :postable_id

      t.timestamps
    end
  end
end
