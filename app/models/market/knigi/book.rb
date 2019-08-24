class Market::Knigi::Book < ApplicationRecord
  include InputConcern
  include SlugConcern

  belongs_to :user
  has_many :libraries, class_name: 'Market::Knigi::Library'
  has_many :added_books, through: :libraries, source: :user
  has_many :pages, as: :commentable, dependent: :destroy, class_name: 'Market::Knigi::Page'

  def publication
    "Не завершено" if self.public.blank?
  end

end
