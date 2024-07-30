class CreateCodes < ActiveRecord::Migration[7.1]
  def change
    create_table :codes do |t|
      t.references :post, null: false, foreign_key: true
      t.integer :language, null: false, default: 0
      t.text :body, null: false

      t.timestamps
    end
  end
end
