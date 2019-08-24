# Auto generate with notifications gem.
class Notification < ActiveRecord::Base
  include Notifications::Model
  # Write your custom methods...
  scope :unread, -> {where(read_at: nil)}
  scope :recent, -> {order(created_at: :desc)}
end
