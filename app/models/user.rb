class User < ApplicationRecord
  has_secure_password

  has_many :user_keywords
  has_many :keywords, through: :user_keywords
  has_many :user_sources
  has_many :sources, through: :user_sources
  has_many :favorites
  # has_many :favorites, through: :user_favorites

  def has_source_name?(input_name)
    sources.map {|source| source.source }.include?(input_name)
  end

end
