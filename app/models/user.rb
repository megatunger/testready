class User < ApplicationRecord
  include Clearance::User
  has_one :student
  def email_optional?
    false
  end
end
