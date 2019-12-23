module YoutubeConcern
  extend ActiveSupport::Concern

  included do
    has_many :youtubes, as: :commentable, dependent: :destroy
    accepts_nested_attributes_for :youtubes, reject_if: :all_blank, allow_destroy: true
  end
end
