module InputConcern
  extend ActiveSupport::Concern

  included do
    validates :title,
              presence: true,
              length: { minimum: 3, maximum: 400 }

    validates_presence_of :user_id
  end
end
