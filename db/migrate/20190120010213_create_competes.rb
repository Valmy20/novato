class CreateCompetes < ActiveRecord::Migration[5.2]
  def change
    create_table :competes do |t|
      t.references :user, foreign_key: true
      t.references :publication, foreign_key: true

      t.timestamps
    end
  end
end
