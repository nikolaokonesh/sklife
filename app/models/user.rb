class User < ApplicationRecord
  include SubscribeConcern
  has_person_name
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable #, :confirmable

  # posts
  has_many :categories, dependent: :destroy, class_name: "Article::Category"
  has_many :posts, dependent: :destroy, class_name: "Article::Post"
  has_many :subscribes, dependent: :destroy, class_name: "Article::Subscribe"

  # books
  has_many :books, dependent: :destroy, class_name: "Market::Knigi::Book"
  has_many :book_orders, dependent: :destroy, class_name: "Market::Knigi::Order"
  has_many :libraries, class_name: "Market::Knigi::Library"
  has_many :library_additions, through: :libraries, source: :book
  has_many :views, dependent: :destroy, class_name: "Market::Knigi::View"
  # has_many :view_addition, through: :views, source: :page

  has_many :comments, dependent: :destroy
  has_many :notifications, foreign_key: :user_id, dependent: :destroy
  has_many :youtubes, dependent: :destroy

  has_many :feedbacks, dependent: :destroy

  noname = %w(Админ Менеджер Автор Агент www
             Admin Administrator Adminka Halyma Sklife
             Manager Managers User Users Book mail Mail майл Майл info Info Инфо инфо
             Books Shop Shops Shopping Oriflame Иванчиненков)

  validates :first_name,
    presence: true,
    exclusion: {
      in: noname,
      message: "%{value} - запрещено использовать это имя."
    }

  validates :last_name,
    presence: true,
    exclusion: {
      in: noname,
      message: "%{value} - запрещено использовать эту фамилию."
    }

  validates_length_of :first_name,
                      :minimum => 1,
                      :maximum => 50

  validates_length_of :last_name,
                      :minimum => 1,
                      :maximum => 50

  # text-sm
  # before_save :capitalize_subdomain
  #def capitalize_subdomain
  #  self.name.titleize
  #end

  validates :slug,
    presence: true,
    uniqueness: true,
    format: {
      with: /^[a-z0-9-]+$/,
      :multiline => true,
      message: ": только буквы и цифры с дефисом"
    },
    length: {
      maximum: 50
    },
    on: :update

  def username
    name.familiar.mb_chars.titleize
  end

  def name_full
    name.full.mb_chars.titleize
  end

  has_one :profile, dependent: :destroy

  after_create :init_profile

  def init_profile
    self.create_profile!
  end

  extend FriendlyId

  friendly_id :slug_candidates, use: :slugged

  after_create :remake_slug

  def slug_candidates
    [
      :name,
      [:name, :id]
    ]
  end

  # FRIENDLY_ID UNIQUE
  def remake_slug
    self.update_attribute(:slug, nil)
    self.save!
  end

  def should_generate_new_friendly_id? #You don't necessarily need this bit, but I have it in there anyways
    new_record? || self.slug.nil?
  end

  private

    # FRIENDLY_ID UPDATE
    def should_generate_new_friendly_id?
      slug.blank?
    end

end
