class AddTestToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :olegs, :test, :string
  end
end
