class User < ApplicationRecord
  include Clearance::User

  def email_optional?
    false
  end
end
