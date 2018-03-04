class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :uid, null:false
      t.string :name, null:false
      t.string :hashed_password
      t.date :start_date, null:false
      t.date :end_date
      t.boolean :suspended, dell:false, default:false
      t.timestamps
    end
    add_index :users, :uid, unique:true
  end
end
