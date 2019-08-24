class Article::Category < ApplicationRecord
  include InputConcern
  include SlugConcern
  include UpgradeConcern
  include YoutubeConcern

  belongs_to :user
  has_many :posts, as: :posttable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
end
