class User < ApplicationRecord
  has_secure_password

  has_many :user_keywords
  has_many :keywords, through: :user_keywords
  has_many :user_sources
  has_many :sources, through: :user_sources
  has_many :user_favorites
  has_many :favorites, through: :user_favorites

end
