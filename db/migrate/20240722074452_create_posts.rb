class CreatePosts < ActiveRecord::Migration[7.1]
  def change
    create_table :posts do |t|
      t.string :title, null: false, default: ''
      t.text :description, default: ''
      t.boolean :public
      t.string :image

      t.timestamps
    end
  end
end
