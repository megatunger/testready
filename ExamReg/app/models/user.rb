class User < ApplicationRecord
  include Clearance::User
  has_one :student, dependent: :destroy
  def email_optional?
    false
  end
end
