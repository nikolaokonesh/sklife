module InputConcern
  extend ActiveSupport::Concern

  included do
    validates :title,
              presence: true,
              length: { minimum: 3, maximum: 150 }

    has_rich_text :body
    validates :body, length: { maximum: 32000 }

    validates_presence_of :user_id
  end
end
