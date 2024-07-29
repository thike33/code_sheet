class Code < ApplicationRecord
  belongs_to :user
  belongs_to :post

  enum language: { html: 0, css: 1, javascript: 2, ruby: 3, php: 4 }

  validates :body, presence: true
end
