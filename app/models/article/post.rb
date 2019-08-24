class Article::Post < ApplicationRecord
  include InputConcern
  include SlugConcern
  include UpgradeConcern
  include YoutubeConcern

  belongs_to :user
  belongs_to :posttable, polymorphic: true, touch: true
  has_many :comments, as: :commentable, dependent: :destroy
end
