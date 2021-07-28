class Tool < ApplicationRecord
  validates :name, :language, presence: true

  before_save { self.name.downcase! }

  scope :with_spec, -> { where.not(spec: nil) }
end
