class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.references :user
      t.references :post
      t.integer :value

      t.timestamps null: false
    end
  end
end
