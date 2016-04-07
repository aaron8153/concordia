class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :name
      t.string :isbn
      t.references :user, index: true, foreign_key: true
      t.references :library, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
