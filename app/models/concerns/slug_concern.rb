module SlugConcern
  extend ActiveSupport::Concern

  included do
    extend FriendlyId
    friendly_id :slug_candidates, use: :slugged
    after_create :remake_slug

    def slug_candidates
      [
        :title,
        [:title, :id]
      ]
    end

    # FRIENDLY_ID UNIQUE
    def remake_slug
      self.update_attribute(:slug, nil)
      self.save!
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
