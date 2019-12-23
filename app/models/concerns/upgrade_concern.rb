module UpgradeConcern
  extend ActiveSupport::Concern

  included do
    before_create :upgrade_create_date
    def upgrade_create_date
      self.upgrade = created_at
    end
  end
end
