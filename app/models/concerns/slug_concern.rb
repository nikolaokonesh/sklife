module SlugConcern
  extend ActiveSupport::Concern

  included do
    extend FriendlyId
    friendly_id :slug_candidates, use: :slugged
    after_create :remake_slug

    def slug_candidates
      [
        :title,
        %i[title id]
      ]
    end

    # FRIENDLY_ID UNIQUE
    def remake_slug
      update_attribute(:slug, nil)
      save!
    end

    # def should_generate_new_friendly_id?
    #   new_record? || self.slug.nil?
    # end

    private

    # FRIENDLY_ID UPDATE
    def should_generate_new_friendly_id?
      slug.blank? || title_changed?
    end
  end
end
