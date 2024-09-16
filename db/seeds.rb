# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# ユーザーを作成
4.times do |index|
  User.create!(
    name: "ユーザー#{index + 1}",
    email: "test#{index + 1}@example.com",
    password: "123456",
    password_confirmation: '123456'
  )
end

user_ids = User.ids

# 投稿を作成
30.times do |index|
  user = User.find(user_ids.sample)
  post = user.posts.create!(
    title: "タイトル#{index + 1}",
    description: "説明文#{index + 1}"
  )

  # コードを作成
  post.codes.create!(
    language: "html",
    body: "<h1>テストコード#{index + 1}</h1>"
  )
end