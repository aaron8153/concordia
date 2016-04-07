class AddDefaultToRecord < ActiveRecord::Migration
  def change
    change_column :records, :num_rentals, :integer, :default => 0
  end
end
