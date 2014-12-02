class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.integer :protein
      t.integer :carbs
      t.integer :fat

      t.timestamps
    end
  end
end
