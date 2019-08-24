class Profile < ApplicationRecord
  has_one_attached :avatar
  has_one_attached :fon

  belongs_to :user

  validates_length_of :bio, :prof, :org, :maximum => 150
  validates_length_of :email, :phone, :maximum => 50
end
