class CreateUserExtras < ActiveRecord::Migration[5.2]
  def change
    create_table :user_extras do |t|
      t.text :bio
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
