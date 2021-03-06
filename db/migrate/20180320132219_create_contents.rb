class CreateContents < ActiveRecord::Migration[5.1]
  def change
    create_table :contents do |t|
      t.string :name, null: false
      t.binary :file
      t.references :user, null: false
      t.references :zone, null: false

      t.timestamps
    end
  end
end
