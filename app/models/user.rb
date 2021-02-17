class User < ApplicationRecord
  has_paper_trail only: [:deleted_at]
  acts_as_paranoid
  has_secure_password

  validates :email,
    presence: true,
    uniqueness: true
end
