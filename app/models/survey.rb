class Survey < ApplicationRecord
  before_create :set_uuid

  encrypts :feeling
  encrypts :comments

  validates :feeling, presence: true
  validates :stress, presence: true, inclusion: { in: 1..5, message: "must be between 1 and 5" }

  private

  def set_uuid
    self.id = SecureRandom.uuid
  end
end
