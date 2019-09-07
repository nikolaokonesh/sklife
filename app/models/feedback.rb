class Feedback < ApplicationRecord

  belongs_to :user

  has_rich_text :message
  validates_presence_of :message
  validates :message, length: { maximum: 3500 }

end
