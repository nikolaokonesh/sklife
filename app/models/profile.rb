class Profile < ApplicationRecord
  has_one_attached :avatar
  has_one_attached :fon

  # supported options: :image, :audio, :video, :text
  validates :avatar, blob: { content_type: :image, size_range: 1..5.megabytes }
  validates :fon, blob: { content_type: :image, size_range: 1..5.megabytes }

  belongs_to :user

  validates_length_of :bio, :maximum => 220
  validates_length_of :prof, :org, :maximum => 150
  validates_length_of :email, :phone, :maximum => 50
end
