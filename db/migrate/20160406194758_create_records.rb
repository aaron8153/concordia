class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |t|
      t.integer :num_rentals
      t.references :library, index: true, foreign_key: true
      t.references :book, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
